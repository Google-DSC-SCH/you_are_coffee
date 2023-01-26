import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:you_are_coffee/kakaoLogin.dart';
import 'package:you_are_coffee/main_view_model.dart';
import 'package:get/get.dart';
//jdk 문제 업데이트
import 'Screens/mainPage.dart';
import 'key.dart';

void main() {
  KakaoSdk.init(nativeAppKey: '3574fc08f6284dba4a884e95dd18d556');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(//Get으로 변경함
      home: const MyHomePage(title: 'You Are Coffee'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //main View모델 생성하고 객체 전달
  final viewModel = MainViewModel(KaKaoLogin());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(128, 255, 204, 204),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/coffee/coffee.jpg'),
            Text(
              '${viewModel.isLogined}',//로그인 여부 확인
              style: Theme.of(context).textTheme.headline4,
            ),
            GestureDetector(
              onTap: () async{
                await viewModel.login();
                debugPrint('The login button has been tapped');
                setState(() {
                });
              },
              child: SizedBox(
                  width: 360,
                  height: 60,
                  child: Image.asset('images/kakao_login_large_narrow.png')
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: ()async{
                  await viewModel.logout();
                  setState(() {

                  });
                },
                child: Text('Logout')
            ),
            ElevatedButton(
                onPressed: () {
                  print('move main page');
                  Get.to(MainPage());
                },
                child: Text('Main')
            ),
          ],
        ),
      ),
    );
  }
}
