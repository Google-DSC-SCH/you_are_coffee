import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'model.dart';
import 'package:like_button/like_button.dart';

//메인 화면에서 커피를 눌렀을떄,
class CoffeePage extends StatefulWidget {
  const CoffeePage({Key? key, required this.coffee}) : super(key: key);
  final Coffee coffee;
  @override
  State<CoffeePage> createState() => _CoffeePageState(coffee);
}

class _CoffeePageState extends State<CoffeePage> {
  final Coffee coffee;
  //커피 리뷰 맵을 만들자.
  List<Map<String, dynamic>> _allCoffeeReview=[];

  _CoffeePageState( this.coffee){//coffeeID를 입력받기 위해 커피클래스로 받는다.
    this._allCoffeeReview =[
      {
        'coffee_id':1,
        'user_id':0,
        'score': 4.0,
        'comment': '늘 마시는 커피지만 정말 선물 받은것 같아요.'
      },
      {
        'coffee_id':1,
        'user_id':0,
        'score': 3.5,
        'comment': '늘 마시는 커피지만 정말 선물 받은것 같아요.'
      },
      {
        'coffee_id':1,
        'user_id':0,
        'score': 5.0,
        'comment': '늘 마시는 커피지만 정말 선물 받은것 같아요.'
      },
      {
        'coffee_id':1,
        'user_id':0,
        'score': 3.0,
        'comment': '늘 맛있게 마시고 있습니다~^^'
      },
      {
        'coffee_id':2,
        'user_id':0,
        'score': 4.0,
        'comment': '신선하고 향기로와서 사무실에서 나누고있어요'
      },
      {
        'coffee_id':2,
        'user_id':0,
        'score': 4.5,
        'comment': '늘 마시는 커피지만 정말 선물 받은것 같아요.'
      },
      {
        'coffee_id':3,
        'user_id':0,
        'score': 2.5,
        'comment': '이번엔 조금 그랬어요ㅠ'
      },
      {
        'coffee_id':3,
        'user_id':0,
        'score': 4.0,
        'comment': '원두 냄새가 구수하네요~'
      },
      {
        'coffee_id':4,
        'user_id':0,
        'score': 3.0,
        'comment': '항상 맛나게 먹고있습니다 :)'
      },
      {
        'coffee_id':4,
        'user_id':0,
        'score': 4.0,
        'comment': '항상 애용하는 원두입니다 산미 있는 걸 좋아하는 저에겐 딱입니다'
      },
    ];
  }
  //커피 리뷰리스트 생성함
  late List<CoffeeReview> reviewData = List.generate(_allCoffeeReview.length, (index) =>
      CoffeeReview(user_id: _allCoffeeReview[index]['user_id'], coffee_id: _allCoffeeReview[index]['coffee_id'],
          comment: _allCoffeeReview[index]['comment'] ,score: _allCoffeeReview[index]['score']),
    growable: true,
  );
  double _ratingValue=3.0;

  bool isLiked = false;
  int likeCount = 0;

  get cnt => 0;


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.red[200],
        title: Text(widget.coffee.name),
      ),
      body: Center(
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
                                  coffee.imgPath,
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
                                      Text(coffee.name,
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
                                      coffee.flavor,
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
                              coffee.description,
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
                          //댓글 영역
                          
                          SizedBox(
                            width: 550,
                            height: 280,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  CheckComment(coffee.ID)[0],
                                  CheckComment(coffee.ID)[1],
                                  CheckComment(coffee.ID)[2]
                        ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                )
              ]
          ),
        ),
    );
  }


  //커피 리스트에서 커피 ID에 맞는 커피 리뷰를 선택
  //댓글들을 리스트 형태로 저장해서 리턴하는 함수
  List<Widget> CheckComment(int coffeeID) {
    List<Widget> reviewList =  new List.empty(growable: true);
    //리뷰 데이터 리스트로 접근해서, 인덱스 마다
    for(int i=0; i<reviewData.length; i++){
      if(reviewData[i].coffee_id==coffeeID){
        //리뷰의 커피 리스트가 커피 ID에 해당한다면 리뷰에 접근
        reviewList.add(Comment(reviewData[i], coffeeID));
        reviewList.add(SizedBox(height: 5,));
      }
    }

    if(reviewList.isEmpty==true){
      reviewList.add(Text('댓글이 없습니다. '));
    }
    return reviewList;
  }


  //커피리뷰 리스트를 입력 받고, 출력할 커피 ID를 같이 입력받음
  //커피 위젯리턴, 사용자 명, 별점, 댓글 내용을 입력받음
  Container Comment(CoffeeReview coffeeReview, int coffeeID){

    return Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 2,
                color: Colors.brown,
              ),
              color: Colors.brown[50],
            ),

            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('${coffeeReview.user_id}',
                        style:TextStyle(fontSize: 20,decorationThickness: 2,)
                    ),
                    RatingBar(
                      itemSize: 27,
                      initialRating: coffeeReview.score,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      ratingWidget: RatingWidget(
                          full: const Icon(Icons.star, color: Colors.orange),
                          half: const Icon(
                            Icons.star_half,
                            color: Colors.orange,
                          ),
                          empty: const Icon(
                            Icons.star_outline,
                            color: Colors.orange,
                          )
                      ), onRatingUpdate: (double value) {  },
                    ),
                    //별점출력
                    Text('${coffeeReview.score}',
                        style:TextStyle(fontSize: 17)
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                //댓글 내용
                Text(
                    '${coffeeReview.comment}',
                    style:TextStyle(fontSize: 15)
                )
              ],
            )
        );
  }
}


