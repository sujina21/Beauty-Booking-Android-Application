import 'dart:convert';

import 'package:beauty_booking_app/app/constants/api_endpoints.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/nails_screen.dart';
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

  Future<void> _pumpNailScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NailScreen(),
      ),
    );
  }

  testWidgets('Displays loading indicator while fetching nail services',
      (WidgetTester tester) async {
    when(() => mockClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => Future.delayed(
              Duration(seconds: 2),
              () => http.Response(json.encode({"data": []}), 200),
            ));

    await _pumpNailScreen(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  // testWidgets('Displays nail services when API returns data',
  //     (WidgetTester tester) async {
  //   final mockResponse = {
  //     "data": [
  //       {
  //         "title": "Gel Nail Polish",
  //         "description": ["Long-lasting gel polish"],
  //         "price": "\$50",
  //         "image": "https://example.com/nail_image.jpg",
  //         "_id": "1"
  //       }
  //     ]
  //   };

  //   when(() => mockClient.get(any(), headers: any(named: 'headers')))
  //       .thenAnswer((_) async => http.Response(json.encode(mockResponse), 200));

  //   await _pumpNailScreen(tester);
  //   await tester.pumpAndSettle();

  //   expect(find.text('Explore Nail Services'), findsOneWidget);
  //   expect(find.text('Gel Nail Polish'), findsOneWidget);
  //   expect(find.text('Long-lasting gel polish'), findsOneWidget);
  //   expect(find.text('\$50'), findsOneWidget);
  // });

  // testWidgets('Handles API error gracefully', (WidgetTester tester) async {
  //   when(() => mockClient.get(any(), headers: any(named: 'headers')))
  //       .thenAnswer((_) async => http.Response('Server Error', 500));

  //   await _pumpNailScreen(tester);
  //   await tester.pumpAndSettle();

  //   expect(find.text('Error: Exception: Failed to load nail services'),
  //       findsOneWidget);
  // });

  // testWidgets('Displays booking popup when "Book Now" is tapped',
  //     (WidgetTester tester) async {
  //   final mockResponse = {
  //     "data": [
  //       {
  //         "title": "Gel Nail Polish",
  //         "description": ["Long-lasting gel polish"],
  //         "price": "\$50",
  //         "image": "https://example.com/nail_image.jpg",
  //         "_id": "1"
  //       }
  //     ]
  //   };

  //   when(() => mockClient.get(any(), headers: any(named: 'headers')))
  //       .thenAnswer((_) async => http.Response(json.encode(mockResponse), 200));

  //   await _pumpNailScreen(tester);
  //   await tester.pumpAndSettle();

  //   await tester.tap(find.text('Book Now').first);
  //   await tester.pumpAndSettle();

  //   expect(find.text('Select Date & Time'), findsOneWidget);
  // });

  // testWidgets('Displays snackbar when added to favorites',
  //     (WidgetTester tester) async {
  //   final mockResponse = {
  //     "data": [
  //       {
  //         "title": "Gel Nail Polish",
  //         "description": ["Long-lasting gel polish"],
  //         "price": "\$50",
  //         "image": "https://example.com/nail_image.jpg",
  //         "_id": "1"
  //       }
  //     ]
  //   };

  //   when(() => mockClient.get(any(), headers: any(named: 'headers')))
  //       .thenAnswer((_) async => http.Response(json.encode(mockResponse), 200));

  //   await _pumpNailScreen(tester);
  //   await tester.pumpAndSettle();

  //   await tester.tap(find.byIcon(Icons.favorite_border).first);
  //   await tester.pumpAndSettle();

  //   expect(find.text('Added to Favourites'), findsOneWidget);
  // });
}
