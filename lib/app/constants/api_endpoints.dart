class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  // // For Android Emulator
  static const String baseUrl = "http://10.0.2.2:7000";

  // For iPhone
  // static const String baseUrl = "http://localhost:6278/api/v1/";

  // ============= Auth Routes =============
  static const String login = "/users/login";
  static const String register = "/users/register";
  static const String deleteUser = "users/delete/";
  static const String getAllUsers = "users/get";

// Makeup
  static const String makeup = "$baseUrl/makeup/";

// nails
  static const String nail = "$baseUrl/nail/";

// booking
  static const String booking = "$baseUrl/booking";
  static const String nailBookingOnly = "$baseUrl/$booking/nails/";
  static const String makeupBookingOnly = "$baseUrl/$booking/makeup/";
  static const String allUserBooking = "$baseUrl/booking/user/";

  // static const String imageUrl = "http://localhost:6278/public/uploads/";
  static const String imageUrl = "http://10.0.2.2:5000/public/uploads/";

  static const String uploadImage = "auth/uploadImage";

  static String accessToken = "";
}
