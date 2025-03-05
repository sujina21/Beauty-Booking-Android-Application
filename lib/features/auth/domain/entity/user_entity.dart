import 'dart:io';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String name;
  final String phone;
  final String email;
  final String password;
  final String? photo;
  final File? file;

  const UserEntity(this.file, {
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    this.photo,
  });

  @override
  List<Object?> get props => [id, email, phone];
}
