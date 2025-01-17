import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sprint_1/app/usecase/usecase.dart';
import 'package:sprint_1/core/error/failure.dart';
import 'package:sprint_1/features/auth/domain/repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : email = '',
        password = '';

  @override
  List<Object> get props => [email, password];
}

class LoginUseCase implements UseCaseWithParams<String, LoginParams> {
  final IAuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    // IF api then store token in shared preferences
    return repository.loginCustomer(params.email, params.password);
  }
}
