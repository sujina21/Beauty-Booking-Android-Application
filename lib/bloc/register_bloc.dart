import 'package:bloc/bloc.dart';
import 'package:sprint_1/bloc/register_event.dart';
import 'package:sprint_1/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(
      RegisterSubmitted event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call

    // Example validation or registration logic
    if (event.password != event.confirmPassword) {
      emit(const RegisterError('Passwords do not match.'));
      return;
    }

    // Simulated success or error
    final isSuccess =
        _registerUser(event.fullName, event.email, event.password);
    if (isSuccess) {
      emit(RegisterSuccess());
    } else {
      emit(const RegisterError('Registration failed. Try again later.'));
    }
  }

  bool _registerUser(String fullName, String email, String password) {
    // Replace this with actual registration logic
    return email != 'alreadyused@example.com'; // Simulated existing email error
  }
}
