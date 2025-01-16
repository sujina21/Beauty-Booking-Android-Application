import 'package:get_it/get_it.dart';
import 'package:sprint_1/cubit/dashboard_cubit.dart';
import 'package:sprint_1/cubit/login_cubit.dart';
import 'package:sprint_1/cubit/onboarding_cubit.dart';
import 'package:sprint_1/cubit/register_cubit.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => DashboardCubit());
  locator.registerLazySingleton(() => OnboardingCubit());
  locator.registerLazySingleton(() => LoginCubit());
  locator.registerLazySingleton(() => RegisterCubit());
}