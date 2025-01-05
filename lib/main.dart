import 'package:flutter/material.dart';
import 'package:sprint_1/app.dart';
import 'package:sprint_1/service_locator/service_locator.dart';

void main() {
  setupServiceLocator(); // Register DashboardService
  setupAuthServiceLocator(); // Register AuthService
  runApp(const MyApp());
}
