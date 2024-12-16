import 'package:flutter/material.dart';
import 'package:sprint_1/view/dashboard_screen.dart';
import 'package:sprint_1/view/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Updated to white background
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Image.asset(
                'lib/assets/image/bnw.png',
                height: 120,
              ),
              const SizedBox(height: 20),
              // App Title
              const Text(
                "The Beauty Aesthetics",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
              const SizedBox(height: 8),
              // Subtitle
              const Text(
                "Book your beauty sessions effortlessly",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: 'OpenSans',
                ),
              ),
              const SizedBox(height: 40),
              // Login Form
              Form(
                child: Column(
                  children: [
                    // Email Input
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Password Input
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Login Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  backgroundColor: Colors.black,
                  shadowColor: Colors.black.withOpacity(0.5),
                  elevation: 10,
                ),
                child: const Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PlayfairDisplay',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Sign-Up Navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                        fontSize: 16,
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
