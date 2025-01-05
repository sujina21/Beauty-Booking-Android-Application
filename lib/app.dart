import 'package:flutter/material.dart';
import 'package:sprint_1/view/dashboard_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Beauty Aesthetics', // App title
      theme: ThemeData(),
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false, // Set the initial screen
    );
  }
}
