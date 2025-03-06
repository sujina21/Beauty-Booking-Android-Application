import 'dart:convert';

import 'package:beauty_booking_app/app/constants/api_endpoints.dart';
import 'package:beauty_booking_app/features/auth/presentation/view/login_view.dart';
import 'package:beauty_booking_app/features/auth/presentation/view/register_view.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/booking_screen.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/makeup_screen.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/nails_screen.dart';
// import 'package:beauty_booking_app/features/auth/presentation/view/login_screen.dart';
// import 'package:beauty_booking_app/features/auth/presentation/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  setUpAll(() {
    registerFallbackValue(Uri.parse('https://example.com'));
  });
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
  });

  Future<void> _pumpWidget(WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(
      MaterialApp(
        home: widget,
      ),
    );
  }

  // group('Booking Screen Tests', () {
  //   testWidgets('Displays loading indicator while fetching bookings',
  //       (WidgetTester tester) async {
  //     when(() => mockClient.get(any(), headers: any(named: 'headers')))
  //         .thenAnswer((_) async => Future.delayed(
  //               Duration(seconds: 2),
  //               () => http.Response(json.encode({"data": []}), 200),
  //             ));

  //     await _pumpWidget(tester, BookingScreen());

  //     expect(find.byType(CircularProgressIndicator), findsOneWidget);
  //   });

  //   testWidgets('Displays bookings when API returns data',
  //       (WidgetTester tester) async {
  //     final mockResponse = {
  //       "data": [
  //         {
  //           "serviceId": {
  //             "title": "Gel Nail Polish",
  //             "image": "https://example.com/nail_image.jpg"
  //           },
  //           "bookingDate": "2025-03-10",
  //           "bookingTime": "14:00",
  //           "status": "Confirmed"
  //         }
  //       ]
  //     };

  //     when(() => mockClient.get(any(), headers: any(named: 'headers')))
  //         .thenAnswer(
  //             (_) async => http.Response(json.encode(mockResponse), 200));

  //     await _pumpWidget(tester, BookingScreen());
  //     await tester.pumpAndSettle();

  //     expect(find.text('Your Upcoming Bookings'), findsOneWidget);
  //     expect(find.text('Gel Nail Polish'), findsOneWidget);
  //     expect(find.text('Date: 2025-03-10\nTime:14:00'), findsOneWidget);
  //     expect(find.text('Status: Confirmed'), findsOneWidget);
  //   });

  //   testWidgets('Handles API error gracefully', (WidgetTester tester) async {
  //     when(() => mockClient.get(any(), headers: any(named: 'headers')))
  //         .thenAnswer((_) async => http.Response('Server Error', 500));

  //     await _pumpWidget(tester, BookingScreen());
  //     await tester.pumpAndSettle();

  //     expect(find.text('Error: Exception: Failed to load bookings'),
  //         findsOneWidget);
  //   });
  // });

  group('Makeup Screen Tests', () {
    testWidgets('Displays loading indicator while fetching makeup services',
        (WidgetTester tester) async {
      when(() => mockClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => Future.delayed(
                Duration(seconds: 2),
                () => http.Response(json.encode({"data": []}), 200),
              ));

      await _pumpWidget(tester, MakeupScreen());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

  //   testWidgets('Displays makeup services when API returns data',
  //       (WidgetTester tester) async {
  //     final mockResponse = {
  //       "data": [
  //         {
  //           "title": "Bridal Makeup",
  //           "description": ["Full bridal makeup package"],
  //           "price": "\$200",
  //           "image": "https://example.com/makeup_image.jpg",
  //           "_id": "1"
  //         }
  //       ]
  //     };

  //     when(() => mockClient.get(any(), headers: any(named: 'headers')))
  //         .thenAnswer(
  //             (_) async => http.Response(json.encode(mockResponse), 200));

  //     await _pumpWidget(tester, MakeupScreen());
  //     await tester.pumpAndSettle();

  //     expect(find.text('Explore Makeup Services'), findsOneWidget);
  //     expect(find.text('Bridal Makeup'), findsOneWidget);
  //     expect(find.text('Full bridal makeup package'), findsOneWidget);
  //     expect(find.text('\$200'), findsOneWidget);
  //   });

  //   testWidgets('Handles API error gracefully', (WidgetTester tester) async {
  //     when(() => mockClient.get(any(), headers: any(named: 'headers')))
  //         .thenAnswer((_) async => http.Response('Server Error', 500));

  //     await _pumpWidget(tester, MakeupScreen());
  //     await tester.pumpAndSettle();

  //     expect(find.text('Error: Exception: Failed to load makeup services'),
  //         findsOneWidget);
  //   });

  //   testWidgets('Displays booking popup when "Book Now" is tapped',
  //       (WidgetTester tester) async {
  //     final mockResponse = {
  //       "data": [
  //         {
  //           "title": "Bridal Makeup",
  //           "description": ["Full bridal makeup package"],
  //           "price": "\$200",
  //           "image": "https://example.com/makeup_image.jpg",
  //           "_id": "1"
  //         }
  //       ]
  //     };

  //     when(() => mockClient.get(any(), headers: any(named: 'headers')))
  //         .thenAnswer(
  //             (_) async => http.Response(json.encode(mockResponse), 200));

  //     await _pumpWidget(tester, MakeupScreen());
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.text('Book Now').first);
  //     await tester.pumpAndSettle();

  //     expect(find.text('Select Date & Time'), findsOneWidget);
  //   });

  //   testWidgets('Displays snackbar when added to favorites',
  //       (WidgetTester tester) async {
  //     final mockResponse = {
  //       "data": [
  //         {
  //           "title": "Bridal Makeup",
  //           "description": ["Full bridal makeup package"],
  //           "price": "\$200",
  //           "image": "https://example.com/makeup_image.jpg",
  //           "_id": "1"
  //         }
  //       ]
  //     };

  //     when(() => mockClient.get(any(), headers: any(named: 'headers')))
  //         .thenAnswer(
  //             (_) async => http.Response(json.encode(mockResponse), 200));

  //     await _pumpWidget(tester, MakeupScreen());
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byIcon(Icons.favorite_border).first);
  //     await tester.pumpAndSettle();

  //     expect(find.text('Added to Favourites'), findsOneWidget);
  //   });
  // });

  group('Nail Screen Tests', () {
    testWidgets('Displays loading indicator while fetching nail services',
        (WidgetTester tester) async {
      when(() => mockClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => Future.delayed(
                Duration(seconds: 2),
                () => http.Response(json.encode({"data": []}), 200),
              ));

      await _pumpWidget(tester, NailScreen());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

  // //   testWidgets('Displays nail services when API returns data',
  // //       (WidgetTester tester) async {
  // //     final mockResponse = {
  // //       "data": [
  // //         {
  // //           "title": "Gel Nail Polish",
  // //           "description": ["Long-lasting gel polish"],
  // //           "price": "\$50",
  // //           "image": "https://example.com/nail_image.jpg",
  // //           "_id": "1"
  // //         }
  // //       ]
  // //     };

  // //     when(() => mockClient.get(any(), headers: any(named: 'headers')))
  // //         .thenAnswer(
  // //             (_) async => http.Response(json.encode(mockResponse), 200));

  // //     await _pumpWidget(tester, NailScreen());
  // //     await tester.pumpAndSettle();

  // //     expect(find.text('Explore Nail Services'), findsOneWidget);
  // //     expect(find.text('Gel Nail Polish'), findsOneWidget);
  // //     expect(find.text('Long-lasting gel polish'), findsOneWidget);
  // //     expect(find.text('\$50'), findsOneWidget);
  // //   });

  // //   testWidgets('Handles API error gracefully', (WidgetTester tester) async {
  // //     when(() => mockClient.get(any(), headers: any(named: 'headers')))
  // //         .thenAnswer((_) async => http.Response('Server Error', 500));

  // //     await _pumpWidget(tester, NailScreen());
  // //     await tester.pumpAndSettle();

  // //     expect(find.text('Error: Exception: Failed to load nail services'),
  // //         findsOneWidget);
  // //   });

  // //   testWidgets('Displays booking popup when "Book Now" is tapped',
  // //       (WidgetTester tester) async {
  // //     final mockResponse = {
  // //       "data": [
  // //         {
  // //           "title": "Gel Nail Polish",
  // //           "description": ["Long-lasting gel polish"],
  // //           "price": "\$50",
  // //           "image": "https://example.com/nail_image.jpg",
  // //           "_id": "1"
  // //         }
  // //       ]
  // //     };

  // //     when(() => mockClient.get(any(), headers: any(named: 'headers')))
  // //         .thenAnswer(
  // //             (_) async => http.Response(json.encode(mockResponse), 200));

  // //     await _pumpWidget(tester, NailScreen());
  // //     await tester.pumpAndSettle();

  // //     await tester.tap(find.text('Book Now').first);
  // //     await tester.pumpAndSettle();

  // //     expect(find.text('Select Date & Time'), findsOneWidget);
  // //   });

  // //   testWidgets('Displays snackbar when added to favorites',
  // //       (WidgetTester tester) async {
  // //     final mockResponse = {
  // //       "data": [
  // //         {
  // //           "title": "Gel Nail Polish",
  // //           "description": ["Long-lasting gel polish"],
  // //           "price": "\$50",
  // //           "image": "https://example.com/nail_image.jpg",
  // //           "_id": "1"
  // //         }
  // //       ]
  // //     };

  // //     when(() => mockClient.get(any(), headers: any(named: 'headers')))
  // //         .thenAnswer(
  // //             (_) async => http.Response(json.encode(mockResponse), 200));

  // //     await _pumpWidget(tester, NailScreen());
  // //     await tester.pumpAndSettle();

  // //     await tester.tap(find.byIcon(Icons.favorite_border).first);
  // //     await tester.pumpAndSettle();

  // //     expect(find.text('Added to Favourites'), findsOneWidget);
  // //   });
  // // });

  // // group('Auth Tests', () {
  // //   testWidgets('Displays login screen', (WidgetTester tester) async {
  // //     await _pumpWidget(tester, LoginView());

  // //     expect(find.text('Login'), findsOneWidget);
  // //     expect(find.byType(TextFormField),
  // //         findsNWidgets(2)); // Email and Password fields
  // //   });

  // //   testWidgets('Displays signup screen', (WidgetTester tester) async {
  // //     await _pumpWidget(tester, RegisterView());

  // //     expect(find.text('Sign Up'), findsOneWidget);
  // //     expect(find.byType(TextFormField),
  // //         findsNWidgets(3)); // Name, Email, and Password fields
  // //   });

  // //   testWidgets('Handles login API call', (WidgetTester tester) async {
  // //     when(() => mockClient.post(any(),
  // //             headers: any(named: 'headers'), body: any(named: 'body')))
  // //         .thenAnswer((_) async =>
  // //             http.Response(json.encode({"token": "dummy_token"}), 200));

  // //     await _pumpWidget(tester, LoginView());
  // //     await tester.enterText(find.byKey(Key('email')), 'test@example.com');
  // //     await tester.enterText(find.byKey(Key('password')), 'password');
  // //     await tester.tap(find.text('Login'));
  // //     await tester.pumpAndSettle();

  // //     expect(find.text('Login Successful'), findsOneWidget);
  // //   });

  //   testWidgets('Handles signup API call', (WidgetTester tester) async {
  //     when(() =>
  //         mockClient.post(any(),
  //             headers: any(named: 'headers'),
  //             body: any(named: 'body'))).thenAnswer((_) async =>
  //         http.Response(json.encode({"message": "Signup Successful"}), 201));

  //     await _pumpWidget(tester, RegisterView());
  //     await tester.enterText(find.byKey(Key('name')), 'Test User');
  //     await tester.enterText(find.byKey(Key('email')), 'test@example.com');
  //     await tester.enterText(find.byKey(Key('password')), 'password');
  //     await tester.tap(find.text('Sign Up'));
  //     await tester.pumpAndSettle();

  //     expect(find.text('Signup Successful'), findsOneWidget);
  //   });
  });
}
  );}