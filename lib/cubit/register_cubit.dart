import 'package:bloc/bloc.dart';
import 'package:sprint_1/bloc/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  void submitRegistration({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(RegisterLoading());
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call

    if (password != confirmPassword) {
      emit(const RegisterError('Passwords do not match.'));
      return;
    }

    final isSuccess = _registerUser(fullName, email, password);
    if (isSuccess) {
      emit(RegisterSuccess());
    } else {
      emit(const RegisterError('Registration failed. Try again.'));
    }
  }

  bool _registerUser(String fullName, String email, String password) {
    // Simulate registration logic
    return email != 'alreadyused@example.com'; // Mock failure for demo
  }
}
