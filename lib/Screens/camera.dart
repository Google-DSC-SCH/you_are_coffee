import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'camera_Result.dart';
import 'package:image/image.dart' as img;
import '../classifier/classifier.dart';
import '../styles.dart';
import 'package:you_are_coffee/Widget/plant_photo_view.dart';

const _labelsFileName = 'assets/labels.txt';
const _modelFileName = 'model_unquant.tflite';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

enum _ResultStatus {
  notStarted,
  notFound,
  found,
}

class _CameraPageState extends State<CameraPage> {
  bool _isAnalyzing = false;
  final picker = ImagePicker();
  File? _selectedImageFile;

  // Result
  _ResultStatus _resultStatus = _ResultStatus.notStarted;
  String _plantLabel = ''; // Name of Error Message
  double _accuracy = 0.0;

  late Classifier _classifier;

  @override
  void initState() {
    super.initState();
    _loadClassifier();
  }

  Future<void> _loadClassifier() async {
    debugPrint(
      'Start loading of Classifier with '
          'labels at $_labelsFileName, '
          'model at $_modelFileName',
    );

    final classifier = await Classifier.loadWith(
      labelsFileName: _labelsFileName,
      modelFileName: _modelFileName,
    );
    _classifier = classifier!;
  }

  @override
  Widget build(BuildContext context) {
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[200],
          title: Text('You Are Coffee'),
          centerTitle: true,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: (){
                print('여기가 설정버튼이여');
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('images/User_Profile_Image.jpg'),
                  backgroundColor: Colors.white,
                ),
                accountName: Text('김주영'),
                accountEmail: Text('아메리카노보다는 그린티라뗴가 좋아'),
                decoration: BoxDecoration(
                    color: Colors.red[200],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular((40.0)),
                        bottomRight: Radius.circular((40.0))
                    )
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('images/coffee/americano.jpg'),
                  backgroundColor: Colors.white,
                ),
                title: Text('아메리카노'),
                onTap: (){
                  print('아메리카노');
                },
                trailing: Icon(Icons.remove_circle),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('images/coffee/latte.jpg'),
                  backgroundColor: Colors.white,
                ),
                title: Text('라뗴'),
                onTap: (){
                  print('라떼');
                },
                trailing: Icon(Icons.remove_circle),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('images/coffee/espresso.jpg'),
                  backgroundColor: Colors.white,
                ),
                title: Text('에스프레쏘'),
                onTap: (){
                  print('에스프레');
                },
                trailing: Icon(Icons.remove_circle),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('images/coffee/macciato.jpg'),
                  backgroundColor: Colors.white,
                ),
                title: Text('마끼아또'),
                onTap: (){
                  print('마끼아');
                },
                trailing: Icon(Icons.remove_circle),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('images/coffee/cappuccino.jpg'),
                  backgroundColor: Colors.white,
                ),
                title: Text('카푸치노'),
                onTap: (){
                  print('카푸치노');
                },
                trailing: Icon(Icons.remove_circle),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('images/coffee/mocha.jpg'),
                  backgroundColor: Colors.white,
                ),
                title: Text('모카'),
                onTap: (){
                  print('모카');
                },
                trailing: Icon(Icons.remove_circle),
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xfff4f3f9),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 60.0,
            ),
            Text("당신은 어떤 커피일까요?", style: TextStyle(
                fontSize: 20
            ),),
            SizedBox(
              height: 40.0,
            ),
            _buildPhotolView(),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildPickPhotoButton(
                  title: '사진 찍기',
                  source: ImageSource.camera,
                ),
                _buildPickGalleryButton(
                  title: '갤러리에서 가져오기',
                  source: ImageSource.gallery,
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () {
                  _buildResultView();
                  print('move camera page');
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[200]
                ),
                child: Text('결과보기')
            ),
          ],
        ));
  }
  Widget _buildPhotolView() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        PlantPhotoView(file: _selectedImageFile),
        _buildAnalyzingText(),
      ],
    );
  }

  Widget _buildAnalyzingText() {
    if (!_isAnalyzing) {
      return const SizedBox.shrink();
    }
    return const Text('분석중...', style: kAnalyzingTextStyle);
  }

  Widget _buildPickGalleryButton({
    required ImageSource source,
    required String title,
  }) {
    return FloatingActionButton(
      backgroundColor: Colors.red[200],
      child: Icon(Icons.wallpaper),
      onPressed: () => _onPickPhoto(source),
    );
  }

  Widget _buildPickPhotoButton({
    required ImageSource source,
    required String title,
  }) {
    return FloatingActionButton(
      backgroundColor: Colors.red[200],
      child: Icon(Icons.add_a_photo),
      onPressed: () => _onPickPhoto(source),
    );
  }
  void _setAnalyzing(bool flag) {
    setState(() {
      _isAnalyzing = flag;
    });
  }

  void _onPickPhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      return;
    }

    final imageFile = File(pickedFile.path);
    setState(() {
      _selectedImageFile = imageFile;
    });

    _analyzeImage(imageFile);
  }

  void _analyzeImage(File image) {
    _setAnalyzing(true);

    final imageInput = img.decodeImage(image.readAsBytesSync())!;

    final resultCategory = _classifier.predict(imageInput);

    final result = resultCategory.score >= 0.7
        ? _ResultStatus.found
        : _ResultStatus.notFound;
    final plantLabel = resultCategory.label;
    final accuracy = resultCategory.score;

    _setAnalyzing(false);

    setState(() {
      _resultStatus = result;
      _plantLabel = plantLabel;
      _accuracy = accuracy;
    });
  }

  Widget _buildResultView() {
    var title = '';

    if (_resultStatus == _ResultStatus.notFound) {
      title = 'Fail to recognise';
    } else if (_resultStatus == _ResultStatus.found) {
      setState(() {
        title = _plantLabel;
      });
    } else {
      title = '';
    }

    //
    var accuracyLabel = '';
    if (_resultStatus == _ResultStatus.found) {
      setState(() {
        accuracyLabel = 'Accuracy: ${(_accuracy * 100).toStringAsFixed(2)}%';
      });
    }

    Get.to(() => CameraResult(), arguments: [
      title?? '신비의'
    ]);

    return Column(
      children: [
        Text(title, style: kResultTextStyle),
        const SizedBox(height: 10),
        Text(accuracyLabel, style: kResultRatingTextStyle)
      ],
    );
  }
}