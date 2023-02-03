import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'mainPage.dart';
import 'dart:math';

class CameraResult extends StatefulWidget {
  const CameraResult({Key? key}) : super(key: key);

  @override
  State<CameraResult> createState() => _CameraResultState();
}

class _CameraResultState extends State<CameraResult> {
  List<Map<String, dynamic>> _Age_20_Coffees =[
    {
      'name' : '에스프레소(Espresso)',
      'comment' : '커피 종류의 기본이 되는, 에스프레소는 곱게 갈아 압축한 원두가루에 뜨거운 물을 고압으로 통과시켜 뽑아낸 이탈리안 정통 커피입니다. 한마디로 아주 쓰고 진한 이탈리아식 커피를 말합니다. 에스프레소는 높은 압력으로 짧은 순간에 커피를 추출하기 때문에 카페인 양이 적고, 커피의 순수한 맛을 느낄 수 있다고 합니다. 아무 것도 넣지 않은 순수한 에스프레소를 카페 에스프레소라고 하고, 2잔 분량을 도피오라고 합니다.',
      'imgPath' : 'images/coffee_20/에스프레소.jpg'
    },
    {
      'name' : '아메리카노(Americano)',
      'comment' : '가장 흔하게 볼 수 있는 커피, 아메리카노입니다. 맛은 좀 더 부드럽게 하기 위해 미국에서 시작되었고, 미국인들이 즐겨 먹는 커피라고 하여 카페 아메리카노(Cafe Americano)라고 불리게 되었습니다. 보통 에스프레소를 뜨거운 물과 1:2 정도의 비율로 희석하며, 농도는 취향에 따라 조절합니다. 물의 비율이 높아질수록 에스프레소 추출 시 나오는 거품인 크레마가 옅어집니다.  또 아메리카노에 설탕을 넣어 먹거나 좋아하는 각종 향시럽을 추가해서 즐길 수도 있습니다.',
      'imgPath' : 'images/coffee_20/아메리카노.jpg'

    },
    {
      'name' : '카페 라떼(Cafe Latte)',
      'comment' : '카페라떼는 에스프레소에 뜨거운 우유를 곁들인 커피입니다. 카페라떼는 전세계에서 찾아볼 수 있는 커피 종류 중 하나로서 에스프레소, 아메리카노와 함께 가장 흔한 종류 중 하나이기도 합니다. 라떼는 이탈리아어로 우유를 뜻합니다.라떼는 1/3의 에스프레소에 나머지를 우유로 넣는 것으로, 우유가 5mm정도 맨 위에 층을 이루고 있는 것이 특징이며 뒤에 설명드릴 카푸치노와 매우 흡사합니다. 다만 두 종류의 차이는 우유와 에스프레소, 거품의 차이입니다.',
      'imgPath' : 'images/coffee_20/카페라떼.jpg'
    },
    {
      'name' : '카푸치노(Cappuccino)',
      'comment' : '카푸치노 레서피는 먼저 커피의 기본인 에스프레소에 우유 3분의 1컵을 끓기 직전까지 데워 얇은 거품을 만들고, 준비한 에스프레소의 가운데에 우유를 넣습니다. 그리고 그 우유 위에 계피가루를 살짝 뿌리면 됩니다. 기호에 따라 우유 거품 대신 휘핑크림을 올리기도 하며, 기호에 따라 시럽을 첨가합니다. 부드럽고도 진한 맛이 특징이입니다.',
      'imgPath' : 'images/coffee_20/카푸치노.jpg'
    },
    {
      'name' : '카페모카(Cafe Mocha)',
      'comment' : '보자마자 느껴지는 진한 초콜릿의 달달함이 떠오르는 커피, 카페모카입니다. 초콜릿 향이 나는 예멘의 스폐셜티 커피인 모카커피를 변형한 것으로 에스프레소에 초콜릿 시럽이나 초콜릿 가루를 넣어 인위적으로 초콜릿 맛을 강조한 커피입니다. 카페모카는 달달해서 인기가 많지만, 크림과 초콜릿이 많이 들어가서 칼로리가 높다는 단점이 있습니다.',
      'imgPath' : 'images/coffee_20/카페모카.jpg'
    },
    {
      'name' : '카라멜마끼야또',
      'comment' : '카라멜 마끼아또에는 바닐라 시럽 그리고 카라멜 소스가 들어가 있습니다. 그렇기 때문에 카라멜의 향과 맛이 커피의 맛을 덮어버릴 정도의 맛을 가지고 있습니다. 메인이 되어야할 커피의 맛이 뒤로 밀려나고 카라멜과 바닐라 시럽의 맛이 주가 되는 상황이 이 메뉴의 특징이라고 할 수 있습니다.',
      'imgPath' : 'images/coffee_20/카라멜마끼아또.jpg'
    },
  ];

  final random = Random().nextInt(6);

  Widget showImage() {
    return Container(
      color: const Color(0xffd0cece),
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.width * 0.8,
      child: Image.asset(_Age_20_Coffees[random]['imgPath'], fit: BoxFit.cover),
      );
  }

  @override
  Widget build(BuildContext context) {
    String user_Age = Get.arguments[0].toString();
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 60.0,
            ),
            Container(
              height: 60,
              width: 300,
              child: Text("당신은 \"${_Age_20_Coffees[random]['name']}\" 같은 ${user_Age}살 입니다", style: TextStyle(
                  fontSize: 20),
            )
            ),
            Container(
              height: 40.0,
            ),
            showImage(),
            Container(
              height: 50.0,
            ),
            Container(
              height: 500,
              width: 270,
              child: Text(
                _Age_20_Coffees[random]['comment'],
                style: TextStyle(fontSize: 20)),
            )
        ],
      ),
    ),
    );
  }
}
