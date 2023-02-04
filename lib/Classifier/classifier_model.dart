
import 'package:tflite_flutter/tflite_flutter.dart';

class ClassifierModel {
  Interpreter interpreter;
  //ClassifierModel 분류자에 대한 모든 모델 관련 데이터를 저장
  //Interpreter의 결과를 통해 예측한다.
  // Get input and output shape from the model
  List<int> inputShape;
  List<int> outputShape;

  TfLiteType inputType;
  TfLiteType outputType;

  ClassifierModel({
    required this.interpreter,
    required this.inputShape,
    required this.outputShape,
    required this.inputType,
    required this.outputType,
  });
}