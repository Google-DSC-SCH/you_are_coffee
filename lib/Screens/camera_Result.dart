import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'mainPage.dart';

class CameraResult extends StatefulWidget {
  const CameraResult({Key? key}) : super(key: key);

  @override
  State<CameraResult> createState() => _CameraResultState();
}

class _CameraResultState extends State<CameraResult> {
  Widget showImage() {
    return Container(
      color: const Color(0xffd0cece),
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.width * 0.8,
      child: Image.asset("assets/coffee/americano.jpg", fit: BoxFit.cover),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[200],
        title: Text('You Are Coffee'),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Get.to(MainPage());
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
                backgroundImage: AssetImage('assets/User_Profile_Image.jpg'),
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
                backgroundImage: AssetImage('assets/coffee/americano.jpg'),
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
                backgroundImage: AssetImage('assets/coffee/latte.jpg'),
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
                backgroundImage: AssetImage('assets/coffee/espresso.jpg'),
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
                backgroundImage: AssetImage('assets/coffee/macciato.jpg'),
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
                backgroundImage: AssetImage('assets/coffee/cappuccino.jpg'),
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
                backgroundImage: AssetImage('assets/coffee/mocha.jpg'),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60.0,
            ),
            Text("당신은 ?? 입니다", style: TextStyle(
                fontSize: 20
            ),),
            const SizedBox(
              height: 40.0,
            ),
            showImage(),
            const SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Container(
              width: 270,
              child: Text(
                  "??가 내뿜는 그윽한 향과 쓴 맛의 풍미로 인한 분위기는 그야말로 당신과 어울립니다", style: TextStyle(fontSize: 20)
              ),
            )

          ],
      ),

    );
  }
}
