// dashboard_event.dart
part of 'dashboard_bloc.dart';

@sealed
abstract class DashboardEvent {
  const DashboardEvent();
}

class DashboardLoadEvent extends DashboardEvent {
  const DashboardLoadEvent();
}
