import 'package:flutter/material.dart';

import 'homepage.dart'; // Import home page

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF2F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF2F8), // Transparent app bar
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "The Beauty Aesthetics",
          style: TextStyle(
            fontFamily: 'Montserrat-Italic',
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const HomeScreen(), 
    );
  }
}
