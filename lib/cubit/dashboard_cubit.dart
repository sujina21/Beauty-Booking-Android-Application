import 'package:flutter_bloc/flutter_bloc.dart';

// States for navigation
abstract class DashboardState {
  final int currentIndex;
  const DashboardState(this.currentIndex);
}

class DashboardInitial extends DashboardState {
  const DashboardInitial() : super(0);
}

class DashboardTabChanged extends DashboardState {
  const DashboardTabChanged(super.currentIndex);
}

// Cubit for dashboard navigation
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardInitial());

  void changeTab(int index) {
    emit(DashboardTabChanged(index));
  }
}
