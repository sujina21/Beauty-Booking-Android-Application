// lib/services/auth_service.dart

class AuthService {
  Future<bool> login(String email, String password) async {
    // Simulating a login process
    await Future.delayed(const Duration(seconds: 2));
    return email == "test@example.com" && password == "password123";
  }

  Future<bool> register(String email, String password) async {
    // Simulating a registration process
    await Future.delayed(const Duration(seconds: 2));
    return true; // Assume registration is successful
  }
}
