import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  void _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) {
    final email = event.email;
    final password = event.password;

    if (email.isEmpty || password.isEmpty) {
      emit(const LoginError("Please fill in all fields"));
    } else if (email == "test@example.com" && password == "password123") {
      emit(LoginSuccess());
    } else {
      emit(const LoginError("Invalid email or password"));
    }
  }
}
