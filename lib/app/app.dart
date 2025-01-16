import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint_1/core/app_theme/app_theme.dart';
import 'package:sprint_1/cubit/login_cubit.dart';
import 'package:sprint_1/cubit/onboarding_cubit.dart';
import 'package:sprint_1/cubit/register_cubit.dart';
import 'package:sprint_1/features/auth/login_screen.dart';
import 'package:sprint_1/features/auth/onboarding_screen.dart';
import 'package:sprint_1/features/auth/register_screen.dart';
import 'package:sprint_1/services/service_locator.dart';
import 'package:sprint_1/view/about_us.dart';
import 'package:sprint_1/view/dashboard_screen.dart';
import 'package:sprint_1/view/favourite_page.dart';
import 'package:sprint_1/view/profile_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                locator<OnboardingCubit>()), // Provide OnboardingCubit
        BlocProvider(
            create: (context) => locator<LoginCubit>()), // Provide LoginCubit
        BlocProvider(
            create: (context) =>
                locator<RegisterCubit>()), // Provide RegisterCubit
      ],
      child: MaterialApp(
        initialRoute: "/",
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        routes: {
          "/": (context) => const DashboardScreen(),
          "/login": (context) => const LoginScreen(),
          "/onboarding": (context) => const OnboardingScreen(),
          "/register": (context) => const RegisterScreen(),
          "/dashboard": (context) => const DashboardScreen(),
          "/profile": (context) => const ProfileScreen(),
          "/favourite": (context) => const FavouriteScreen(),
          "/about": (context) => const AboutUsScreen(),
        },
      ),
    );
  }
}
