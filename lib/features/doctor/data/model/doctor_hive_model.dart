import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:myasteer/app/constants/hive_table_constant.dart';
import 'package:myasteer/features/doctor/domain/entity/doctor_entity.dart';
import 'package:uuid/uuid.dart';

part 'doctor_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.doctorTableId)
class DoctorHiveModel extends Equatable {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String specialization;

  @HiveField(3)
  final String availableDays;

  @HiveField(4)
  final String availableTimes;

  @HiveField(5)
  final String contact;

  @HiveField(6)
  final String email;

  DoctorHiveModel(
      {String? id,
      required this.name,
      required this.specialization,
      required this.availableDays,
      required this.availableTimes,
      required this.contact,
      required this.email})
      : id = id ?? const Uuid().v4();

  // Initial Constructor
  const DoctorHiveModel.initial()
      : id = '',
        name = '',
        specialization = '',
        availableDays = '',
        availableTimes = '',
        contact = '',
        email = '';

  // From Entity
  factory DoctorHiveModel.fromEntity(DoctorEntity entity) {
    return DoctorHiveModel(
      id: entity.id,
      name: entity.name,
      specialization: entity.specialization,
      availableDays: entity.availableDays,
      availableTimes: entity.availableTimes,
      contact: entity.contact,
      email: entity.email,
    );
  }

  // To Entity
  DoctorEntity toEntity() {
    return DoctorEntity(
      id: id,
      name: name,
      specialization: specialization,
      availableDays: availableDays,
      availableTimes: availableTimes,
      contact: contact,
      email: email,
    );
  }

  // To Entity List
  static List<DoctorEntity> toEntityList(List<DoctorHiveModel> entityList) {
    return entityList.map((data) => data.toEntity()).toList();
  }

  // From entity list
  static List<DoctorHiveModel> fromEntityList(List<DoctorEntity> entityList) {
    return entityList
        .map((entity) => DoctorHiveModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props =>
      [id, name, specialization, availableDays, availableTimes, contact, email];
}
