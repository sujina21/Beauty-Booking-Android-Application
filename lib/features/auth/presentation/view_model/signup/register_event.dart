part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterCustomer extends RegisterEvent {
  final BuildContext context;
  final String fName;
  final String lName;
  final String phone;
  final String email;
  final String password;

  const RegisterCustomer({
    required this.context,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.email,
    required this.password,
  });
}
