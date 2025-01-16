import 'package:flutter/material.dart';
import 'package:sprint_1/app/app.dart';
import 'package:sprint_1/services/service_locator.dart';

void main() {
  setupLocator(); // Setup for service locator

  runApp(const MyApp());
}
