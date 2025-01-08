import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myasteer/app/constants/hive_table_constant.dart';
import 'package:myasteer/features/auth/domain/entity/auth_entity.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? studentId;
  @HiveField(1)
  final String fName;
  @HiveField(2)
  final String lName;
  @HiveField(3)
  final String? image;

  @HiveField(4)
  final String username;
  @HiveField(5)
  final String password;

  AuthHiveModel({
    String? studentId,
    required this.fName,
    required this.lName,
    this.image,
    required this.username,
    required this.password,
  }) : studentId = studentId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : studentId = '',
        fName = '',
        lName = '',
        image = '',
        username = '',
        password = '';

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      studentId: entity.userId,
      fName: entity.fName,
      lName: entity.lName,
      image: entity.image,
      username: entity.username,
      password: entity.password,
    );
  }

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: studentId,
      fName: fName,
      lName: lName,
      image: image,
      username: username,
      password: password,
    );
  }

  @override
  List<Object?> get props =>
      [studentId, fName, lName, image, username, password];
}
