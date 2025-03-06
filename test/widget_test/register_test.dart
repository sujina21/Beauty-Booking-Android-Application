import 'dart:io';

import 'package:beauty_booking_app/features/auth/presentation/view/register_view.dart';
import 'package:beauty_booking_app/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterBloc extends Mock implements RegisterBloc {}

void main() {
  late RegisterBloc registerBloc;

  setUp(() {
    registerBloc = MockRegisterBloc();
    registerFallbackValue(File('path/to/image'));
  });

  Widget createTestWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<RegisterBloc>.value(
        value: registerBloc,
        child: child,
      ),
    );
  }

  testWidgets('Register form validation and submit',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(const RegisterView()));

    // Find fields and button
    final nameField = find.byKey(const Key('fullName'));
    final emailField = find.byKey(const Key('email'));
    final phoneField = find.byKey(const Key('phone'));
    final passwordField = find.byKey(const Key('password'));
    final confirmPasswordField = find.byKey(const Key('confirmPassword'));
    final registerButton = find.byKey(const Key('registerButton'));

    // Enter invalid values
    await tester.enterText(nameField, '');
    await tester.enterText(emailField, 'invalidemail');
    await tester.enterText(phoneField, '');
    await tester.enterText(passwordField, '123');
    await tester.enterText(confirmPasswordField, '123');

    await tester.tap(registerButton);
    await tester.pump();

    // Validate error messages
    expect(find.text('Please enter full name'), findsOneWidget);
    expect(find.text('Please enter a valid email'), findsOneWidget);
    expect(find.text('Please enter your phone'), findsOneWidget);
    expect(find.text('Password must be at least 8 characters'), findsOneWidget);

    // Enter valid values
    await tester.enterText(nameField, 'Sujina Shrestha');
    await tester.enterText(emailField, 'sujinasht@gmail.com');
    await tester.enterText(phoneField, '9846031459');
    await tester.enterText(passwordField, 'sujina123');
    await tester.enterText(confirmPasswordField, 'sujina123');

    await tester.tap(registerButton);
    await tester.pump();

    // Verify RegisterUser event triggered
    verify(() => registerBloc.add(RegisterUser(
          File('path/to/image'),
          name: 'Sujina Shrestha',
          phone: '9846031459',
          email: 'sujinasht@gmail.com',
          password: 'sujina123',
        ))).called(1);
  });

  testWidgets('Image selection and upload', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(const RegisterView()));

    final profileImageButton = find.byKey(const Key('profileImage'));

    await tester.tap(profileImageButton);
    await tester.pumpAndSettle();

    final galleryButton = find.text('Gallery');
    await tester.tap(galleryButton);
    await tester.pump();

    verify(() => registerBloc.add(LoadImage(file: any(named: 'file'))))
        .called(1);
  });

  testWidgets('Check password visibility toggle', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(const RegisterView()));

    final passwordToggleButton =
        find.byKey(const Key('passwordVisibilityToggle'));
    final confirmPasswordToggleButton =
        find.byKey(const Key('confirmPasswordVisibilityToggle'));

    // Initial state: both should be visibility_off
    expect(find.byIcon(Icons.visibility_off), findsNWidgets(2));

    // Toggle password field visibility
    await tester.tap(passwordToggleButton);
    await tester.pump();
    expect(find.byIcon(Icons.visibility), findsOneWidget);
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);

    // Toggle confirm password visibility
    await tester.tap(confirmPasswordToggleButton);
    await tester.pump();
    expect(find.byIcon(Icons.visibility), findsNWidgets(2));
  });
}
