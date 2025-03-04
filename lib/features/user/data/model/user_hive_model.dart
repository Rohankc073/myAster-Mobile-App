import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myAster/features/user/domain/entity/user_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';

part 'user_hive_model.g.dart';

// Command to Generate Adapter: dart run build_runner build -d
// Need to run each time changes are made to the model.

@HiveType(typeId: HiveTableConstant.userTableId)
class UserHiveModel extends Equatable {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? contact;

  @HiveField(3)
  final String? email;

  @HiveField(4)
  final String image;

  @HiveField(5)
  final String specialization;

  UserHiveModel({
    String? id,
    required this.name,
    this.contact,
    this.email,
    required this.image,
    required this.specialization,
  }) : id = id ?? const Uuid().v4();

  // Initial Constructor
  const UserHiveModel.initial()
      : id = '',
        name = '',
        contact = null,
        image = '',
        specialization = '',
        email = null;

  // From Entity
  factory UserHiveModel.fromEntity(UserEntity entity) {
    return UserHiveModel(
      id: entity.id,
      name: entity.name,
      contact: entity.contact,
      email: entity.email,
      image: entity.image,
      specialization: entity.specialization,
    );
  }

  // To Entity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      contact: contact,
      image: image,
      email: email,
      specialization: specialization,
    );
  }

  // To Entity List
  static List<UserHiveModel> fromEntityList(List<UserEntity> entityList) {
    return entityList
        .map((entity) => UserHiveModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => [id, name, contact, email, image, specialization];
}
