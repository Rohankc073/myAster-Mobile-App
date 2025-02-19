import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myasteer/features/doctor/domain/entity/doctor_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';

part 'doctor_hive_model.g.dart';

// Command to Generate Adapter: dart run build_runner build -d
// Need to run each time changes are made to the model.

@HiveType(typeId: HiveTableConstant.doctorTableId)
class DoctorHiveModel extends Equatable {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? contact;

  @HiveField(3)
  final String? email;

  DoctorHiveModel({
    String? id,
    required this.name,
    this.contact,
    this.email,
  }) : id = id ?? const Uuid().v4();

  // Initial Constructor
  const DoctorHiveModel.initial()
      : id = '',
        name = '',
        contact = null,
        email = null;

  // From Entity
  factory DoctorHiveModel.fromEntity(DoctorEntity entity) {
    return DoctorHiveModel(
      id: entity.id,
      name: entity.name,
      contact: entity.contact,
      email: entity.email,
    );
  }

  // To Entity
  DoctorEntity toEntity() {
    return DoctorEntity(
      id: id,
      name: name,
      contact: contact,
      email: email,
    );
  }

  // To Entity List
  static List<DoctorHiveModel> fromEntityList(List<DoctorEntity> entityList) {
    return entityList
        .map((entity) => DoctorHiveModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => [
        id,
        name,
        contact,
        email,
      ];
}
