// dashboard_bloc.dart
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardInitial()) {
    on<DashboardLoadEvent>((event, emit) async {
      emit(const DashboardLoading()); // Show loading state

      try {
        // Simulate data fetching
        await Future.delayed(
            const Duration(seconds: 2)); // Simulating a network delay
        String fetchedData =
            "Dashboard data loaded"; // This should be your data

        emit(DashboardLoaded(fetchedData)); // Yield loaded state with data
      } catch (e) {
        emit(DashboardError(
            e.toString())); // Emit error state if something goes wrong
      }
    });
  }
}
