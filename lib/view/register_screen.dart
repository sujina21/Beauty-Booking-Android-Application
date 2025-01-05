import 'package:flutter/material.dart';
import 'package:sprint_1/services/auth_service.dart';
import 'package:get_it/get_it.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _authService =
        GetIt.instance<AuthService>(); // Access AuthService
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController =TextEditingController();
    final _formKey = GlobalKey<FormState>();

    // Function to handle registration
    void _handleRegister() async {
      if (_formKey.currentState!.validate()) {
        if (_passwordController.text == _confirmPasswordController.text) {
          bool isRegistered = await _authService.register(
            _emailController.text,
            _passwordController.text,
          );

          if (isRegistered) {
            // If registration is successful, navigate to login or dashboard
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration successful')),
            );
            Navigator.pop(context); // Go back to the login screen
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration failed')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Passwords do not match')),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("The Beauty Aesthetics"),
        backgroundColor: const Color.fromARGB(255, 255, 233, 244),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Image.asset(
                'assets/image/bnw.png',
                height: 120,
              ),
              const SizedBox(height: 20),
              // Title and Subtitle
              const Text(
                "Create Your Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B5E83),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Join us and start your beauty journey today!",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4B4B4B),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Form Fields
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Full Name Input
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: const TextStyle(
                          color: Color(0xFF8B5E83),
                          fontWeight: FontWeight.w600,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon:
                            const Icon(Icons.person, color: Color(0xFF8B5E83)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    // Email Address Input
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: const TextStyle(
                          color: Color(0xFF8B5E83),
                          fontWeight: FontWeight.w600,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon:
                            const Icon(Icons.email, color: Color(0xFF8B5E83)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    // Password Input
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          color: Color(0xFF8B5E83),
                          fontWeight: FontWeight.w600,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon:
                            const Icon(Icons.lock, color: Color(0xFF8B5E83)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    // Confirm Password Input
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: const TextStyle(
                          color: Color(0xFF8B5E83),
                          fontWeight: FontWeight.w600,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.lock_outline,
                            color: Color(0xFF8B5E83)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Sign-Up Button
              ElevatedButton(
                onPressed: _handleRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEE3A60),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4B4B4B),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Go back to the login screen
                    },
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFEE3A60),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
