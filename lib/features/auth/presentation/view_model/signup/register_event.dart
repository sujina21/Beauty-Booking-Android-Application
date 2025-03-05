part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}


class LoadImage extends RegisterEvent {
  final File file;

  const LoadImage({
    required this.file,
  });
}

class RegisterUser extends RegisterEvent {
  final File file;
  final String name;
  final String phone;
  final String email;
  final String password;
  final String? photo;

  const RegisterUser(this.file,{
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    this.photo,
  });

  @override
  List<Object> get props => [
        name,
        phone,
        email,
        password,
      ];
}
