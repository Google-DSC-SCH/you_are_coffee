import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../Data/Coffee/coffee.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double _ratingValue = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(128, 255, 204, 204),
          title: Text('You Are Coffee'),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        ),
        //드로어 추가
        drawer: Drawer(
          // 앱바 왼편에 햄버거 버튼 생성
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('images/coffee/coffee.jpg'),
                  backgroundColor: Colors.white,
                ),
                accountName: Text('UserName'),
                accountEmail: Text('UserID'),
                onDetailsPressed: () {
                  print('arrow is clicked');
                },
                decoration: BoxDecoration(
                    color: Colors.brown[200],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0))),
              ),
              ListTile(
                leading: Image.asset('images/coffee/Americano.jpg'),
                title: Text('Americano', style: TextStyle(fontSize: 20)),
                onTap: () {
                  print('Americano is clicked');
                },
                subtitle: RatingBar(
                    initialRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Colors.orange),
                        half: const Icon(
                          Icons.star_half,
                          color: Colors.orange,
                        ),
                        empty: const Icon(
                          Icons.star_outline,
                          color: Colors.orange,
                        )),
                    onRatingUpdate: (value) {
                      setState(() {
                        _ratingValue = value;
                      });
                    }),
              ),
              ListTile(
                leading: Image.asset('images/coffee/caffeLatte.jpg'),
                title: Text('caffeLatte', style: TextStyle(fontSize: 20)),
                onTap: () {
                  print('caffeLatte is clicked');
                },
                subtitle: RatingBar(
                    initialRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Colors.orange),
                        half: const Icon(
                          Icons.star_half,
                          color: Colors.orange,
                        ),
                        empty: const Icon(
                          Icons.star_outline,
                          color: Colors.orange,
                        )),
                    onRatingUpdate: (value) {
                      setState(() {
                        _ratingValue = value;
                      });
                    }),
              ),
              ListTile(
                leading: Image.asset('images/coffee/cappuccino.jpg'),
                title: Text('cappuccino', style: TextStyle(fontSize: 20)),
                onTap: () {
                  print('cappuccino is clicked');
                },
                subtitle: RatingBar(
                    initialRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Colors.orange),
                        half: const Icon(
                          Icons.star_half,
                          color: Colors.orange,
                        ),
                        empty: const Icon(
                          Icons.star_outline,
                          color: Colors.orange,
                        )),
                    onRatingUpdate: (value) {
                      setState(() {
                        _ratingValue = value;
                      });
                    }),
              ),
            ],
          ),
        ),
        body: ListView(
              padding: EdgeInsets.all(30),
              children: <Widget>[
                MainCoffeeTile(imageLink: 'images/coffee/Americano.jpg',coffeeName: 'Americano', flavor1: '신맛',flavor2: '쓴맛'),
                MainCoffeeTile(imageLink: 'images/coffee/caffeLatte.jpg',coffeeName: 'caffeLate', flavor1: '부드러운맛',flavor2: '단맛'),
                MainCoffeeTile(imageLink: 'images/coffee/cappuccino.jpg',coffeeName: 'capuccino', flavor1: '단맛',flavor2: '쓴맛'),
                MainCoffeeTile(imageLink: 'images/coffee/Americano.jpg',coffeeName: 'Americano', flavor1: '신맛',flavor2: '쓴맛'),
                MainCoffeeTile(imageLink: 'images/coffee/caffeLatte.jpg',coffeeName: 'caffeLate', flavor1: '부드러운맛',flavor2: '단맛'),
                MainCoffeeTile(imageLink: 'images/coffee/cappuccino.jpg',coffeeName: 'capuccino', flavor1: '단맛',flavor2: '쓴맛'),
                MainCoffeeTile(imageLink: 'images/coffee/Americano.jpg',coffeeName: 'Americano', flavor1: '신맛',flavor2: '쓴맛'),
                MainCoffeeTile(imageLink: 'images/coffee/caffeLatte.jpg',coffeeName: 'caffeLate', flavor1: '부드러운맛',flavor2: '단맛'),
                MainCoffeeTile(imageLink: 'images/coffee/cappuccino.jpg',coffeeName: 'capuccino', flavor1: '단맛',flavor2: '쓴맛'),
              ],
        ),
    );
  }
}

//MainCoffeeTile() ct1 =new MainCoffeeTile(imageLink: 'images/coffee/Americano.jpg',)
//메인화면에 커피 타일을 생성하는 클래스
class MainCoffeeTile extends StatelessWidget{

  MainCoffeeTile({super.key, required this.imageLink, required this.coffeeName, required this.flavor1,required this.flavor2});

  late String imageLink = 'images/coffee/coffee.jpg';//이미지 링크
  late String coffeeName = '커피';
  late String flavor1 = '맛';
  late String flavor2 = '맛';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(imageLink),
      title: Text(coffeeName, style: TextStyle(fontSize: 20)),
      subtitle: Text('#$flavor1, #$flavor2'),
      onTap: () {
        print('$coffeeName is clicked');
      },
      trailing: Icon(Icons.favorite, color: Colors.grey),
    );
  }
}
