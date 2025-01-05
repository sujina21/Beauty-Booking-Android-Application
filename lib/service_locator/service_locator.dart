// lib/service_locator.dart
import 'package:get_it/get_it.dart';
import 'package:sprint_1/services/auth_service.dart';
import 'package:sprint_1/services/dashboard_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<DashboardService>(() => DashboardService());
}

void setupAuthServiceLocator() {
  getIt.registerLazySingleton<AuthService>(() => AuthService());
}
