class coffeeImage {
  late final int like_id;
  late final int user_id;
  late final int coffee_id;
  late final bool like;

  coffeeImage({required this.like_id, required this.user_id, required this.coffee_id, required this.like});
}

// < COFFEE_LIKE >
// like_id(INT unsigned auto_increment)
// like
// coffee_id (INT unsigned)
// user_id (INT unsigned)