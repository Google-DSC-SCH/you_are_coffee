//플러터에서 텐서플로 사용 - tflite_flutter 패키지로 TF lite라이브러리 액세스
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
//텐서 플로 입력 및 출력을 조작 가능 이미지 데이터를 텐서 구조로 변환 전후처리 놀리 노력을 줄여줌
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
//이미지 분류자를 Classifier라고 부름
import 'classifier_category.dart';
import 'classifier_model.dart';
//라벨 및 모델로드 -> 이미지 전처리 -> 모델 사용 -> TensorFlow 출력후 처리 ->범주출력 선택및 작성
//플러터 이미지를 텐서 플로 입력 텐서로 변환 label 다음 모델을 실행하고, 출력을 포함하는
//최종 레코드인 score로 변환하는 것
typedef ClassifierLabels = List<String>;

class Classifier {

  final ClassifierLabels _labels;
  final ClassifierModel _model;

  Classifier._({
    required ClassifierLabels labels,
    required ClassifierModel model,
  })  : _labels = labels,
        _model = model;

  static Future<Classifier?> loadWith({
    required String labelsFileName,
    required String modelFileName,
  }) async {
    try {
      final labels = await _loadLabels(labelsFileName);
      final model = await _loadModel(modelFileName);
      //위 코드로 모델 파일을 로드함
      return Classifier._(labels: labels, model: model);
      //초기화를 위한 코드이다.
      //사용자가 제공하는 이미지를 인식하는 Classifier인스턴스가 빌드 완료됨
    } catch (e) {
      debugPrint('Can\'t initialize Classifier: ${e.toString()}');
      if (e is Error) {
        debugPrintStack(stackTrace: e.stackTrace);
      }
      return null;
    }
  }

  static Future<ClassifierModel> _loadModel(String modelFileName) async {
    final interpreter = await Interpreter.fromAsset(modelFileName);
    //제공된 모델 파일로 인터프리터를 생성한다. 인터프리터가 결과를 예측하는 도구
    //데이터 전처리, 후처리를 수행하는데 사용할 입력 및 출력 영역을 정의 해둔다.
    //가지고 있는 자료형을 알도록 자료형도 정의해둠
    final inputShape = interpreter.getInputTensor(0).shape;
    final outputShape = interpreter.getOutputTensor(0).shape;

    debugPrint('Input shape: $inputShape');
    debugPrint('Output shape: $outputShape');

    // Get input and output type from the model
    final inputType = interpreter.getInputTensor(0).type;
    final outputType = interpreter.getOutputTensor(0).type;

    debugPrint('Input type: $inputType');
    debugPrint('Output type: $outputType');

    return ClassifierModel(
      interpreter: interpreter,
      inputShape: inputShape,
      outputShape: outputShape,
      inputType: inputType,
      outputType: outputType,
    );
  }

  static Future<ClassifierLabels> _loadLabels(String labelsFileName) async {
    final rawLabels = await FileUtil.loadLabels(labelsFileName);
    //tfilte_flutter_helper에서 파일 유틸리티를 사용해 레이블 업로드함
    //이전에 다운로드한 레이블에서 색인 번호 접두어를 제거한다. 0 rose-> rose
    //결과값 라벨을 초기화 시킨다.
    final labels = rawLabels
        .map((label) => label.substring(label.indexOf(' ')).trim())
        .toList();

    debugPrint('Labels: $labels');
    return labels;
  }

  void close() {
    _model.interpreter.close();
  }

  ClassifierCategory predict(Image image) {
    debugPrint(
      'Image: ${image.width}x${image.height}, '
          'size: ${image.length} bytes',
    );

    // Load the image and convert it to TensorImage for TensorFlow Input
    //이미지를 로드하고 텐서플로 입력을 위한 이미지로 전환하는 과정
    final inputImage = _preProcessInput(image);

    debugPrint(
      'Pre-processed image: ${inputImage.width}x${image.height}, '
          'size: ${inputImage.buffer.lengthInBytes} bytes',
    );

    // Define the output buffer
    //출력 버퍼를 정의
    final outputBuffer = TensorBuffer.createFixedSize(
      _model.outputShape,
      _model.outputType,
    );

    // Run inference
    //추론을 실행
    _model.interpreter.run(inputImage.buffer, outputBuffer.buffer);

    debugPrint('OutputBuffer: ${outputBuffer.getDoubleList()}');

    // Post Process the outputBuffer
    //outputBuffer 후처리를 진행함
    final resultCategories = _postProcessOutput(outputBuffer);
    final topResult = resultCategories.first;

    debugPrint('Top category: $topResult');

    return topResult;
  }

  //처리 결과값 변환단계
  //_postProcessOutput()으로 이제 예측을 호출만 을면됨
  List<ClassifierCategory> _postProcessOutput(TensorBuffer outputBuffer) {
    //TensorProcessorBuilder 출력을 구문 분석하고 처리할 인스턴스를 만든다.
    final probabilityProcessor = TensorProcessorBuilder().build();

    probabilityProcessor.process(outputBuffer);
    //출력값을 레이블에 매핑한다.
    final labelledResult = TensorLabel.fromList(_labels, outputBuffer);

    //label-score 레코드 목록으로 범주 인스턴스를 빌드한다.
    final categoryList = <ClassifierCategory>[];
    labelledResult.getMapWithFloatValue().forEach((key, value) {
      final category = ClassifierCategory(key, value);
      categoryList.add(category);
      debugPrint('label: ${category.label}, score: ${category.score}');
    });
    //가장 가능성이 높은 결과가 맨 위에 오도록 목록을 정렬한다.
    categoryList.sort((a, b) => (b.score > a.score ? 1 : -1));

    return categoryList;
  }

  //이미지 데이터 전처리를 위해 존재하는 함수 tflite_flutter_helper의 도움으로 이미지 재구성
  //처리하기 위해 가져올 수 있는 여러 함수를 제공하기 때문에 이미지 처리가 간단하다.
  TensorImage _preProcessInput(Image image) {
    // #1
    //TensorImage 이미지 데이터를 생성하고 로드하기
    final inputTensor = TensorImage(_model.inputType);
    inputTensor.loadImage(image);

    // #2
    //이미지를 정사각형 모양으로 잘라냄
    final minLength = min(inputTensor.height, inputTensor.width);
    final cropOp = ResizeWithCropOrPadOp(minLength, minLength);

    // #3
    //모델의 요구 사항에 맞게 이미지 작업 크기를 조정함
    final shapeLength = _model.inputShape[1];
    final resizeOp = ResizeOp(shapeLength, shapeLength, ResizeMethod.BILINEAR);

    // #4
    //데이터 값을 정규화 한다. 127.5학습된 모델의 매개변수 때문에 인수가 선택되었음
    //     이미지의 0-255를 -1-1범위로 변환하려 함
    final normalizeOp = NormalizeOp(127.5, 127.5);

    // #5 이미지를 적합한 크기로 잘라주는 작업
    //정의 된 작업으로 이미지 프로세서를 생성하고 이미지를 전처리
    //전처리된 이미지를 반환한다.
    final imageProcessor = ImageProcessorBuilder()
        .add(cropOp)
        .add(resizeOp)
        .add(normalizeOp)
        .build();

    imageProcessor.process(inputTensor);

    // #6
    //전처리 된 이미지를 반환한다.
    return inputTensor;
  }
}
