import 'package:get_it/get_it.dart';
import 'package:sprint_1/bloc/dashboard_bloc.dart';
import 'package:sprint_1/bloc/login_bloc.dart';
import 'package:sprint_1/bloc/register_bloc.dart';
import 'package:sprint_1/features/auth/login_screen.dart';
import 'package:sprint_1/features/auth/onboarding_screen.dart';
import 'package:sprint_1/features/auth/register_screen.dart';

// Create an instance of GetIt
final GetIt locator = GetIt.instance;

Future<void> initDependencies() async {
  await _initLoginDependencies();
  await _initRegisterDependencies();
  await _initDashboardDependencies();
}       

_initLoginDependencies() async {
  locator.registerFactory<LoginBloc>(() => LoginBloc());
}

_initRegisterDependencies() async {
  locator.registerFactory<RegisterBloc>(() => RegisterBloc());
}

_initDashboardDependencies() async {
  locator.registerFactory<DashboardBloc>(() => DashboardBloc());
}
