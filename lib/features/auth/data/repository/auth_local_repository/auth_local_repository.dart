import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sprint_1/core/error/failure.dart';
import 'package:sprint_1/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:sprint_1/features/auth/domain/entity/auth_entity.dart';
import 'package:sprint_1/features/auth/domain/repository/auth_repository.dart';

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepository(this._authLocalDataSource);

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final currentUser = await _authLocalDataSource.getCurrentUser();
      return Right(currentUser);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginCustomer(
    String email,
    String password,
  ) async {
    try {
      final token = await _authLocalDataSource.loginCustomer(email, password);
      return Right(token);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerCustomer(AuthEntity customer) async {
    try {
      return Right(_authLocalDataSource.registerCustomer(customer));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final filePath = await _authLocalDataSource.uploadProfilePicture(file);
      return Right(filePath);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
