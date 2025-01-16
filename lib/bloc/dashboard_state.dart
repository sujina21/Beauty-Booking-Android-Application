// dashboard_state.dart
part of 'dashboard_bloc.dart';

@sealed
abstract class DashboardState {
  const DashboardState();
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoaded extends DashboardState {
  final String data;
  const DashboardLoaded(this.data);
}

class DashboardError extends DashboardState {
  final String message;
  const DashboardError(this.message);
}
