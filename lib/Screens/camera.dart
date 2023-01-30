import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'camera_Result.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _image;
  final picker = ImagePicker();

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
  }

  // 이미지를 보여주는 위젯
  Widget showImage() {
    return Container(
        color: const Color(0xffd0cece),
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.width * 0.8,
        child: Center(
            child: _image == null
                ? Text('No image selected.')
                : Image.file(File(_image!.path))));
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
            showImage(),
            SizedBox(
              height: 50.0,
            ),


            //카메라 기능
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // 카메라 촬영 버튼
                FloatingActionButton(
                  backgroundColor: Colors.red[200],
                  child: Icon(Icons.add_a_photo),
                  tooltip: 'pick Iamge',
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                ),

                // 갤러리에서 이미지를 가져오는 버튼
                FloatingActionButton(
                  backgroundColor: Colors.red[200],
                  child: Icon(Icons.wallpaper),
                  tooltip: 'pick Iamge',
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  print('move camera page');
                  Get.to(CameraResult());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[200]
                ),
                child: Text('결과보기')
            ),
          ],
        ));
  }
}
