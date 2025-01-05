import 'package:flutter/material.dart';
import 'package:sprint_1/view/homepage.dart'; // Import HomeScreen

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "The Beauty Aesthetics",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          // bold text
        ),
      ),
      body: const HomeScreen(), // Display HomeScreen here
    );
  }
}
