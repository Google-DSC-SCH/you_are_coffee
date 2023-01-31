//커피 객체 커피ID, 이름, 이미지경로, 맛, 간단설명
class Coffee{
  final int ID;
  final String name;
  final String imgPath;
  final String flavor;
  final String description;

  Coffee(this.ID, this.name, this.imgPath, this.flavor, this.description);
}
//커피 리뷰를 저장
class CoffeeReview {
   final int user_id;
   final int coffee_id;
   final double score;
  String comment = '.';

  CoffeeReview({ required this.user_id, required this.coffee_id, required this.comment, required this.score });
}

//커피 좋아요 표시 여부 사용자-커피ID로 기록
class coffeeLike {
  final int like_id;
  int user_id;
  final int coffee_id;
  final bool like;

  coffeeLike({required this.like_id, this.user_id=0, required this.coffee_id, required this.like});
}

//커피의 ID 별로 커피의 평균 점수를 기록하는 클래스
class coffeeScore{
  final int coffee_id;
  int score_cnt=1;//별점 준 사람의 숫자
  double average_score=3.0;
  double score=3.0;//받은 점수
  coffeeScore({required this.coffee_id, required this.score});//커피 아이디랑 입력 점수로만 초기화 하면 된다.

  void calAverage() {//평점이 추가 될떄 이를 계산
    average_score = (average_score* score_cnt+score)/(score_cnt+1);
    score_cnt++;
  }
}