import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';
import '../../domain/entity/user_entity.dart';

part 'user_hive_model.g.dart';
// dart run build_runner build -d

@HiveType(typeId: HiveTableConstant.userTableId)
class UserHiveModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String phone;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String password;

  @HiveField(5)
  final String? photo;

  UserHiveModel({
    String? id,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    this.photo,
  }) : id = id ?? const Uuid().v4();

  /// Initial constructor with default values
  const UserHiveModel.initial()
      : id = '',
        name = '',
        phone = '',
        email = '',
        password = '',
        photo = null;

  /// Convert from entity
  factory UserHiveModel.fromEntity(UserEntity entity) {
    return UserHiveModel(
      id: entity.id ?? const Uuid().v4(),
      name: entity.name,
      phone: entity.phone,
      email: entity.email,
      password: entity.password,
      photo: entity.photo?.isEmpty ?? true ? null : entity.photo,
    );
  }

  /// Convert to entity
  UserEntity toEntity() {
    return UserEntity(
      null,
      id: id,
      name: name,
      email: email,
      password: password,
      photo: photo, 
      phone: phone,
    );
  }

  /// Convert a list of entities to Hive models
  static List<UserHiveModel> fromEntityList(List<UserEntity> entityList) {
    return entityList
        .map((entity) => UserHiveModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        email,
        password,
        photo,
      ];
}
