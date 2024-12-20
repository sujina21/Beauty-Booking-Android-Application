import 'package:flutter/material.dart';
import 'package:sprint_1/core/app_theme/app_theme.dart';
import 'package:sprint_1/view/dashboard_screen.dart';
import 'package:sprint_1/view/login_screen.dart';
import 'package:sprint_1/view/onboarding_screen.dart';
import 'package:sprint_1/view/register_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: "/",
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        routes: {
          "/": (context) => const OnboardingScreen(),
          "/login": (context) => const LoginScreen(),
          "/onboarding": (context) => const OnboardingScreen(),
          "/register": (context) => const RegisterScreen(),
          "/dashboard": (context) => const DashboardScreen(),
        });
  }
}
