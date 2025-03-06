import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/nails_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  testWidgets('Test Nail Screen UI', (WidgetTester tester) async {
    // Pump the NailScreen widget
    await tester.pumpWidget(MaterialApp(home: NailScreen()));

    // Test if the AppBar and title are displayed
    expect(find.text('Nail Services'), findsOneWidget);
    expect(find.text('Explore Nail Services'), findsOneWidget);

    // Test if the loading indicator is shown initially
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Simulate a response for FutureBuilder to show data
    await tester.pumpAndSettle();

    // Test if the "Book Now" button is present
    expect(find.text('Book Now'), findsWidgets); // Multiple buttons

    // Tap the first "Book Now" button
    await tester.tap(find.text('Book Now').first);
    await tester.pumpAndSettle();

    // Test if the date and time picker pop-up is shown
    expect(find.text('Select Date & Time'), findsOneWidget);

    // Test selecting a date
    await tester.tap(find.byIcon(Icons.calendar_today));
    await tester.pumpAndSettle();
    expect(find.byType(DatePickerDialog),
        findsOneWidget); // Assuming DatePickerDialog shows up

    // Test selecting a time
    await tester.tap(find.byIcon(Icons.access_time));
    await tester.pumpAndSettle();
    expect(find.byType(TimePickerDialog),
        findsOneWidget); // Assuming TimePicker shows up

    // Test the "Confirm" button in the pop-up
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();

    // Test snackbar appearance
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Booking Successful!'), findsOneWidget);

    // Test the "Favorite" button functionality
    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pumpAndSettle();
    expect(find.text('Added to Favourites'), findsOneWidget);
  });
}
