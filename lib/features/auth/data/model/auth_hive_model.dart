import 'package:equatable/equatable.dart';
import 'package:sprint_1/app/constants/hive_table_constant.dart';
import 'package:sprint_1/features/auth/domain/entity/auth_entity.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.customerTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? customerId;
  @HiveField(1)
  final String fName;
  @HiveField(2)
  final String lName;
  @HiveField(3)
  final String? image;
  @HiveField(4)
  final String phone;
  @HiveField(5)
  final String email;
  @HiveField(6)
  final String password;

  AuthHiveModel({
    String? customerId,
    required this.fName,
    required this.lName,
    this.image,
    required this.phone,
    required this.email,
    required this.password,
  }) : customerId = customerId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : customerId = '',
        fName = '',
        lName = '',
        image = '',
        phone = '',
        email = '',
        password = '';

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      customerId: entity.userId,
      fName: entity.fName,
      lName: entity.lName,
      image: entity.image,
      phone: entity.phone,
      email: entity.email,
      password: entity.password,
    );
  }

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: customerId,
      fName: fName,
      lName: lName,
      image: image,
      phone: phone,
      email: email,
      password: password,
    );
  }

  @override
  List<Object?> get props =>
      [customerId, fName, lName, image, phone, email, password];
}
