class user {
  late final int user_id;
  late final String user_name;
  late final String email;
  late final dynamic picture;
  late final String? access_token;
  late final Set<String>? role = {'user', 'moderator', 'admin'};
  late final Set<String>? type = {'naver', 'google', 'kakao'};
  DateTime? created_at;
  DateTime? updated_at;
  //created_at, updated_at

  user({required this.user_id,required this.user_name, required this.email,
    required this.picture, //accesstoken, role, type
  });
}

// < USERS >
// user_id (INT unsigned auto_increment)
// username
// email
// picture
// access_token
// role(user, moderator, admin)
// type(naver, google, kakao)
// created_at (DATETIME)
// updated_at (DATETIME)
