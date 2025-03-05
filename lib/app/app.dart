import 'package:beauty_booking_app/features/auth/presentation/view/login_view.dart';
import 'package:beauty_booking_app/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/theme/app_theme.dart';
import 'di/di.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beauty Booking App',
      theme: AppTheme.getApplicationTheme(isDarkMode: false),
      home: BlocProvider<LoginBloc>(
        create: (context) => getIt<LoginBloc>(),
        child: LoginView(),
      ),
    );
  }
}
