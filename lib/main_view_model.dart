import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:you_are_coffee/socialLogin.dart';

class MainViewModel{
  final SocialLogin _socialLogin; //로그인 객체 하나 생성
  bool isLogined = false;//로그인 여부 체크변수
  User? user;//사용자 객체, 카카오sdk에 존재

  MainViewModel(this._socialLogin);
  //로그인 기능의 로그인
  Future login() async{
    isLogined = await _socialLogin.login();//로그인을 시도
    if(isLogined) {
      user = await UserApi.instance.me();//로그인이 성공하면 유저정보를 가져옴
    }
  }
  //
  Future logout() async{
    await _socialLogin.logout();
    isLogined=false;//로그아웃됨
    user = null;//사용자는 NULL로
  }

}