// Mock dependencies
import 'package:beauty_booking_app/features/auth/domain/use_case/login_user_usecase.dart';
import 'package:beauty_booking_app/features/auth/presentation/view/login_view.dart';
import 'package:beauty_booking_app/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:beauty_booking_app/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:beauty_booking_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterBloc extends Mock implements RegisterBloc {}

class MockHomeCubit extends Mock implements HomeCubit {}

class MockLoginUserUsecase extends Mock implements LoginUserUsecase {}

void main() {
  late LoginBloc loginBloc;
  late RegisterBloc registerBloc;
  late HomeCubit homeCubit;
  late LoginUserUsecase loginUserUsecase;

  setUp(() {
    registerBloc = MockRegisterBloc();
    homeCubit = MockHomeCubit();
    loginUserUsecase = MockLoginUserUsecase();

    loginBloc = LoginBloc(
      registerBloc: registerBloc,
      homeCubit: homeCubit,
      loginUserUsecase: loginUserUsecase,
    );
  });

  testWidgets('Email and Password Validation', (WidgetTester tester) async {
    // Wrap the test with the required providers
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<LoginBloc>.value(
          value: loginBloc,
          child: LoginView(),
        ),
      ),
    );

    // Find text fields
    final emailField = find.byKey(Key('email'));
    final passwordField = find.byKey(Key('password'));

    // Enter text
    await tester.enterText(emailField, 'sujina@gmail.com');
    await tester.enterText(passwordField, 'sujina123');

    // Ensure UI updates
    await tester.pump();

    // Verify that the text has been entered correctly
    expect(find.text('sujina@gmail.com'), findsOneWidget);
    expect(find.text('sujina123'), findsOneWidget);
  });

  testWidgets('Invalid Email and Password Validation',
      (WidgetTester tester) async {
    // Wrap the test with the required providers
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<LoginBloc>.value(
          value: loginBloc,
          child: LoginView(),
        ),
      ),
    );

    // Find text fields
    final emailField = find.byKey(Key('email'));
    final passwordField = find.byKey(Key('password'));
    final loginButton = find.byKey(Key('loginButton'));

    // Enter an invalid email and a short password
    await tester.enterText(emailField, 'invalid-email');
    await tester.enterText(passwordField, 'short');

    // Ensure UI updates
    await tester.pump();

    // Tap the login button
    await tester.tap(loginButton);
    await tester.pump();

    // // Check for validation messages
    // expect(find.text('Enter a valid email address'), findsOneWidget);
    // expect(find.text('Password must be at least 8 characters'), findsOneWidget);
  });
}
