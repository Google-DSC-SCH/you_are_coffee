import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:like_button/like_button.dart';
import '../Data/Coffee/coffee.dart';
import 'coffee_Page.dart';
import 'model.dart';

class MainPage extends StatefulWidget{
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>  with SingleTickerProviderStateMixin{

  // 모든 커피 데이터
  //List Coffee를 초기화하기 위해서는 Coffee맵을 static으로 선언해야 참조대상인 인스턴스가 변동없음을 확인 시켜줄 수가 있다.
  static List<Map<String, dynamic>> _allCoffees =[
    {"id" : 1, "name" : "아메리카노", "imgPath" : "images/coffee/americano.jpg", "flavor" : "쓴맛, 신맛", "description" : "아메리카노는 써"},
    {"id" : 2, "name" : "카푸치노", "imgPath" : "images/coffee/cappuccino.jpg", "flavor" : "쓴맛, 떫은맛", "description" : "카푸치노는 몰라"},
    {"id" : 3, "name" : "에스프레소", "imgPath" : "images/coffee/espresso.jpg", "flavor" : "쓴맛, 완전 쓴맛", "description" : "에스프레소는 완전 써"},
    {"id" : 4, "name" : "라떼", "imgPath" : "images/coffee/latte.jpg", "flavor" : "단맛, 꾸덕한맛", "description" : "라떼는 달아"},
    {"id" : 5, "name" : "마끼아또", "imgPath" : "images/coffee/macciato.jpg", "flavor" : "쓴맛, 단맛", "description" : "마끼아또는 달콤해"},
    {"id" : 6, "name" : "모카", "imgPath" : "images/coffee/mocha.jpg", "flavor" : "쓴맛, 모카향", "description" : "모카는 풍미가 좋아"},
    {"id" : 7, "name" : "아메리카노", "imgPath" : "images/coffee/americano.jpg", "flavor" : "쓴맛, 신맛", "description" : "아메리카노는 써"},
    {"id" : 8, "name" : "카푸치노", "imgPath" : "images/coffee/cappuccino.jpg", "flavor" : "쓴맛, 떫은맛", "description" : "카푸치노는 몰라"},
    {"id" : 9, "name" : "에스프레쏘", "imgPath" : "images/coffee/espresso.jpg", "flavor" : "쓴맛, 완전 쓴맛", "description" : "에스프레소는 완전 써"},
    {"id" : 10, "name" : "라떼", "imgPath" : "images/coffee/latte.jpg", "flavor" : "단맛, 꾸덕한맛", "description" : "라떼는 달아"},
    {"id" : 11, "name" : "마끼아또", "imgPath" : "images/coffee/macciato.jpg", "flavor" : "쓴맛, 단맛", "description" : "마끼아또는 달콤해"},
    {"id" : 12, "name" : "모카", "imgPath" : "images/coffee/mocha.jpg", "flavor" : "쓴맛, 모카향", "description" : "모카는 풍미가 좋아"},
  ];
  //커피 찾기로 받을 리스트
  List<Map<String, dynamic>> _foundCoffees =[];

  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('어떤 커피를 찾으시나요?');

  //커피리스트를 생성해서 커피 객체로 초기화 하는 방식
  final List<Coffee> coffeeData = List.generate(_allCoffees.length, (index) =>
      Coffee(_allCoffees[index]['name'],_allCoffees[index]['imgPath'],_allCoffees[index]['flavor'], _allCoffees[index]['description'] ));
      //Coffee(coffeeName[index],coffeeImagePath[index],coffeeFlavor[index], coffeeDescription[index] ));

  //플로팅액션버튼에 사용하는 것들
  late AnimationController _animationController;  // Animation controller
  late Animation<double> _buttonAnimatedIcon; // This is used to animate the icon of the main FAB
  late Animation<double> _translateButton;  // This is used for the child FABs
  bool _isExpanded = false;                 // This variable determnies whether the child FABs are visible or not
  //***

  double _ratingValue = 3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red[200],
            title: Text('You Are Coffee'),

            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
        ),
          //드로어 추가 내가 좋아한 커피 확인페이지
          drawer: Drawer(
            // 앱바 왼편에 햄버거 버튼 생성
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                //사용자 정보 업데이트 하는 곳
                UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('images/coffee/coffee.jpg'),
                    backgroundColor: Colors.white,
                  ),
                  accountName: Text('UserName'),
                  accountEmail: Text('UserID'),
                  decoration: BoxDecoration(
                      color: Colors.brown[200],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0))),
                ),
                //내가 좋아한 커피 확인 위젯
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

          //메인 화면 내에 리스트 뷰로 커피들 출력
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: false,
                onChanged: (value) => _runFilter(value),
                decoration: const InputDecoration(
                  labelText: '어떤 커피를 찾으시나요?',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: _foundCoffees.isNotEmpty?
                  ListView.builder(
                    itemCount: _foundCoffees.length,
                    itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundCoffees[index]["id"]),
                      color: Colors.white,
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset(_foundCoffees[index]["imgPath"],)
                        ),
                        title: Text(_foundCoffees[index]["name"]),
                        subtitle: Text(_foundCoffees[index]["flavor"]),
                        onTap: (){Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CoffeePage(coffee: coffeeData[index],)));
                        debugPrint(coffeeData[index].name);
                        },
                      ),

                    ),
                  ): const Text(
                    'No results found',
                    style: TextStyle(fontSize: 24),
                  )
              )
            ],
          ),
        ),

        // 카메라 기능 넣을 플로팅 버튼
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //버튼 돌리기
            Transform(
              transform: Matrix4.translationValues(
                0,
                _translateButton.value * 3,
                0,
              ),
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                //카메라 팝업 출력되는 이벤트 발생
                onPressed: () {
                  showCameraPopup(context);
                },
                child: const Icon(
                  Icons.camera_alt_outlined,
                ),
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(
                0,
                _translateButton.value * 2,
                0,
              ),
              child: FloatingActionButton(
                backgroundColor: Colors.amber,
                onPressed: () {
                  showCameraPopup(context);
                },
                child: const Icon(
                    Icons.photo_camera_back
                ),
              ),
            ),
            // This is the primary FAB
            FloatingActionButton(
              onPressed: _toggle,
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: _buttonAnimatedIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 이 기능은 텍스트 필드가 변경될 때마다 호출됩니다
  void _runFilter(String enteredKeyword){
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty){
      // 검색 필드가 비어 있거나 공백만 포함된 경우 모든 커피를 표시합니다
      results = _allCoffees;
    }else{
      results = _allCoffees.where((coffee) =>
          coffee["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // 대소문자를 구분하지 않도록 toLowerCase() 메서드를 사용합니다
    }

    // UI 새로 고침
    setState(() {
      _foundCoffees = results;
    });
  }

  // ****** 플로팅액션버튼에 사용하는 메소드 *****
  @override
  initState() {
    // 처음에 모든 커피를 모여준다 JY
    _foundCoffees = _allCoffees;

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))
      ..addListener(() {
        setState(() {});
      });

    _buttonAnimatedIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _translateButton = Tween<double>(
      begin: 100,
      end: -20,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    super.initState();
  }

  // dispose the animation controller
  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // This function is used to expand/collapse the children floating buttons
  // It will be called when the primary FAB (with menu icon) is pressed
  _toggle() {
    if (_isExpanded) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    _isExpanded = !_isExpanded;
  }
  //******************************************


  // 카메라 결과창
  void showCameraPopup(context) {
    bool isLiked = false;

    showDialog(
        context: context,
        builder: (context){
          return Dialog(
              child: Container(
                width: MediaQuery.of(context).size.width*0.8,
                height: MediaQuery.of(context).size.height*0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: Column(
                    children: [
                      // 유저 프로필 사진
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'images/coffee/coffee.jpg',
                          width: 200,
                          height: 200,
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      //**********************************************
                      /* ** 여기에 나이 스크롤바?막대그래프? 항목 넣기 ** */
                      //********************************************

                      // ㅁㅁ님은 혹시 00세?? 부분
                      const Text('UserName님은 혹시 00세??',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      const Text('이런 커피 한 잔 마셔볼래요?',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // 추천 커피 보여주기 부분
                      Container(
                        width: MediaQuery.of(context).size.width*0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200]
                        ),
                        child: Row(
                          children: [
                            //커피 이미지
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'images/coffee/coffee.jpg',
                                width: 100,
                                height: 100,
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            // 커피 이름, 맛, 별점
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text('coffeeName',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Text(
                                    '#flavor1, #flavor2',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[500]
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RatingBar(
                                    initialRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 20,
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
                              ],
                            )
                          ],
                        ),
                      ),

                      //아이콘 버튼 - 좋아요, 다운로드
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LikeButton(
                            size: 40,
                            isLiked: isLiked,
                          ),

                          const SizedBox(
                            width: 50,
                          ),

                          IconButton(
                            icon: const Icon(Icons.cloud_download, size: 40),
                            color: Colors.grey[600],
                            onPressed: () {},
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      ElevatedButton.icon(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                        label: const Text('close'),
                      ),
                    ],
                  ),
                ),

              )
          );
        }
    );
  }
}



/*
MainCoffeeTile() ct1 =new MainCoffeeTile(imageLink: 'images/coffee/Americano.jpg',)
//메인화면에 커피 타일을 생성하는 클래스(_MainCoffeeTileState와 묶음이다.)
class MainCoffeeTile extends StatefulWidget{

  MainCoffeeTile({super.key, required this.imageLink, required this.coffeeName, required this.flavor1,required this.flavor2});

  late String imageLink = 'images/coffee/coffee.jpg';//이미지 링크
  late String coffeeName = '커피';
  late String flavor1 = '맛';
  late String flavor2 = '맛';

  @override
  State<MainCoffeeTile> createState() => _MainCoffeeTileState();
}


//coffeeTile 자체를 Stateful위젯으로 생성해서 클릭시 설명 위젯 띄우는 메서드를 이용
class _MainCoffeeTileState extends State<MainCoffeeTile>{

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(widget.imageLink),
      title: Text(widget.coffeeName, style: TextStyle(fontSize: 20)),
      subtitle: Text('#${widget.flavor1}, #${widget.flavor2}'),
      onTap: () {
        print('${widget.coffeeName} is clicked');
        showCoffeePopup(context, widget.imageLink, widget.coffeeName, widget.flavor1, widget.flavor2);
      },
      trailing: Icon(Icons.favorite, color: Colors.grey),
    );
  }

  // 커피 상세정보 창
  void showCoffeePopup(context, imageLink, coffeeName, flavor1, flavor2) {
    double _ratingValue = 3;
    bool isLiked = false;
    String description = '커피상세설명\n설명\n설명설명\n설명\n설명\n설명\n설명설명설명';

    showDialog(
        context: context,
        builder: (context){
          return Dialog(
            // 댓글작성용 키보드 나타날 때, 화면 스크롤 넣어서 화면 잘리는 오류 방지
            child:SingleChildScrollView(
              child: Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width*0.8,
                        height: MediaQuery.of(context).size.height*0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                          child: Column(
                            children: [
                              // 커피 이미지, 이름, 맛, 별점 항목란
                              Row(
                                children: [
                                  //커피 이미지
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      imageLink,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  // 커피 이름, 맛, 별점
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Text(coffeeName,
                                            style: const TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          LikeButton(
                                            size: 20,
                                            isLiked: isLiked,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Text(
                                          '#$flavor1, #$flavor2',
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[500]
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      RatingBar(
                                          initialRating: 0,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 20,
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
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              // 커피 상세설명
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.7,
                                child: Text(
                                  description,
                                  maxLines: 7,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[700]
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),

                              // 상세설명글과 댓글 사이의 구분선
                              Divider(
                                height: 30.0,
                                color: Colors.brown[600],
                                thickness: 1,
                                endIndent: 30,
                              ),

                              // 사용자 평가 항목
                              const Text(
                                '평가 및 리뷰',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey
                                ),
                              ),
                              RatingBar(
                                  initialRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20,
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

                              // 여백 넣은거
                              const SizedBox(
                                height: 10,
                              ),

                              // 사용자 평가 항목 - 리뷰작성 텍스트필드, 메시지전송버튼
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width*0.6,
                                      child: const TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Reply',
                                          hintText: 'Enter your review',
                                          labelStyle: TextStyle(color: Colors.redAccent),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                            borderSide: BorderSide(width: 1, color: Colors.redAccent),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                            borderSide: BorderSide(width: 1, color: Colors.redAccent),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                          ),
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.mail_outline, size: 40),
                                    color: Colors.grey[600],
                                    onPressed: () {},
                                  ),
                                ],
                              ),

                              // 여백 넣은거
                              const SizedBox(
                                height: 20,
                              ),


                              // ***********************
                              /* ** 댓글 기능 넣을 부분 ** */
                              // **********************


                              // 팝업 닫기 버튼
                              ElevatedButton.icon(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.close),
                                label: const Text('close'),
                              ),
                            ],
                          ),
                        )
                    )
                  ]
              ),
            ),
          );
        }
    );
  }
}
*/

