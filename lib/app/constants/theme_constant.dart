import 'package:flutter/material.dart';

class AppTheme {
  // Define color constants
  static const Color primaryColor = Colors.indigo;
  static const Color accentColor = Colors.indigoAccent;
  static const Color backgroundColor = Colors.white;
  static const Color formFillColor = Colors.grey; // Use Colors.grey directly
  static const Color errorColor = Colors.red;

  // Define text style constants
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle labelTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: primaryColor,
  );

  static const TextStyle errorTextStyle = TextStyle(
    color: errorColor,
    fontWeight: FontWeight.bold,
  );

  // Define input decoration for form fields
  static InputDecoration formInputDecoration({
    required IconData prefixIcon,
    required String labelText,
  }) {
    return InputDecoration(
      prefixIcon: Icon(prefixIcon, color: primaryColor),
      labelText: labelText,
      labelStyle: labelTextStyle,
      filled: true,
      fillColor:
          formFillColor.withAlpha(26), // Using .withAlpha to set transparency
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
            color:
                formFillColor.withAlpha(77)), // Adjust alpha for transparency
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor),
      ),
    );
  }

  // Define theme for app bar
  static AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: primaryColor,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    elevation: 0,
  );

  // Define theme for buttons
  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: primaryColor,
    padding: EdgeInsets.symmetric(vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}
