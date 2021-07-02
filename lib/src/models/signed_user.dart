class SignedUser {
  String name;
  String email;
  String password;
  static String token;

  SignedUser({this.name, this.email, this.password});

  SignedUser.fromRepository(String userId) {
    // ignore: prefer_initializing_formals
    SignedUser.token = userId;
  }
}
