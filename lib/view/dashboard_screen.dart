import 'package:flutter/material.dart';

import 'homepage.dart';

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
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: const HomeScreen(),
    );
  }
}
