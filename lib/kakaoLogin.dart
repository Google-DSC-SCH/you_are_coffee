import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:you_are_coffee/socialLogin.dart';

class KaKaoLogin implements SocialLogin {
  @override
  Future<bool> login() async{
    try{
      bool isInstalled = await isKakaoTalkInstalled();
      if(isInstalled){ //카카오톡이 설치 되었는지 확인
        await UserApi.instance.loginWithKakaoTalk();
        return true;
      }else {//카카오톡이 설치 안되어 있으면 카카오 계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
        }catch(e) {
          return false;
        }
      }
     return true;
    }catch(e) {
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.unlink(); //로그아웃 메서드
      return true;
    }catch(error) {
      return false;
    }
  }
}

/*
카카오 버튼
child: GestureDetector(
onTap: () {
debugPrint('The image button has been tapped');
},
child: SizedBox(
width: 360,
height: 60,
child: Image.asset('images/kakao_login_large_narrow.png')
),
),
 */