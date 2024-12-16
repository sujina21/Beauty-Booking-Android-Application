import 'package:flutter/material.dart';
import 'package:sprint_1/view/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login and Register',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const OnboardingScreen());
  }
}
