class SignedUser {
  static String token;

  SignedUser.fromRepository(String userId) {
    // ignore: prefer_initializing_formals
    SignedUser.token = userId;
  }
}
