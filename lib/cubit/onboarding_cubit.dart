import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  void changePage(int pageIndex) {
    emit(pageIndex);
  }

  void nextPage() {
    if (state < 2) {
      emit(state + 1);
    }
  }

  bool isLastPage() => state == 2;
}
