class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  // // For Android Emulator
  static const String baseUrl = "http://10.0.2.2:5000/api/v1/";

  // For iPhone
  // static const String baseUrl = "http://localhost:6278/api/v1/";

  // ============= Auth Routes =============
  static const String login = "auth/sign-in";
  static const String register = "auth/sign-up";
  static const String deleteUser = "auth/delete/";
  static const String getAllUsers = "auth/getAllUsers/";

  // static const String imageUrl = "http://localhost:6278/public/uploads/";
  static const String imageUrl = "http://10.0.2.2:5000/public/uploads/";

  static const String uploadImage = "auth/uploadImage";
}
