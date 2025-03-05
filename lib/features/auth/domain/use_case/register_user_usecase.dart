import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/user_entity.dart';
import '../repository/user_repository.dart';

class CreateUserParams extends Equatable {
  final String? id;
  final String name;
  final String phone;
  final String email;
  final String password;
  final String? photo;
  final File? file;

  const CreateUserParams(this.file, {
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    this.photo
  });

  @override
  List<Object?> get props => [
        name,
        phone,
        email,
        password,
        photo,
      ];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'photo': photo,
      'file':file
    };
  }
}

class CreateUserUsecase implements UsecaseWithParams<void, CreateUserParams> {
  final IUserRepository userRepository;

  const CreateUserUsecase({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(CreateUserParams params) async {
    // Create the user entity from the params
    final userEntity = UserEntity(params.file,
      id: null,
      // The ID will be generated automatically
      name: params.name,
      email: params.email,
      password: params.password,
      photo: params.photo, 
      phone: params.phone,
      // dob: params.dob,
    );

    // Call the repository method to create the user
    return await userRepository.createUser(userEntity);
  }
}
