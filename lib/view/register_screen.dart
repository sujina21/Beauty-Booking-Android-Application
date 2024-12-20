import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF2F8), // Matches onboarding page
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
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Join us and start your beauty journey today!",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4B4B4B),
                  fontFamily: 'OpenSans',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Form Fields
              Form(
                child: Column(
                  children: [
                    // Full Name Input
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: const TextStyle(
                          color: Color(0xFF8B5E83),
                          fontFamily: 'OpenSans',
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
                    ),
                    const SizedBox(height: 20),
                    // Email Address Input
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: const TextStyle(
                          color: Color(0xFF8B5E83),
                          fontFamily: 'OpenSans',
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
                    ),
                    const SizedBox(height: 20),
                    // Password Input
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          color: Color(0xFF8B5E83),
                          fontFamily: 'OpenSans',
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
                    ),
                    const SizedBox(height: 20),
                    // Confirm Password Input
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: const TextStyle(
                          color: Color(0xFF8B5E83),
                          fontFamily: 'OpenSans',
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
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Sign-Up Button
              ElevatedButton(
                onPressed: () {
                  // Handle sign-up logic here
                },
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
                    fontFamily: 'PlayfairDisplay',
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
                      fontFamily: 'OpenSans',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFEE3A60),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
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
