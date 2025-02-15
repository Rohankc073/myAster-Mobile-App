import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myasteer/features/doctor/domain/entity/doctor_entity.dart';

part 'doctor_api_model.g.dart';

@JsonSerializable()
class DoctorApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String specialization;
  final String availableDays;
  final String availableTimes;
  final String contact;
  final String email;

  const DoctorApiModel(
      {this.id,
      required this.name,
      required this.specialization,
      required this.availableDays,
      required this.availableTimes,
      required this.contact,
      required this.email});

  factory DoctorApiModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorApiModelToJson(this);

  // To entity

// From Entity
  factory DoctorApiModel.fromEntity(DoctorEntity entity) {
    return DoctorApiModel(
        id: entity.id,
        name: entity.name,
        specialization: entity.specialization,
        availableDays: entity.availableDays,
        availableTimes: entity.availableTimes,
        email: entity.email,
        contact: entity.contact);
  }

  // To Entity
  DoctorEntity toEntity() {
    return DoctorEntity(
        id: id,
        name: name,
        specialization: specialization,
        availableDays: availableDays,
        availableTimes: availableTimes,
        email: email,
        contact: contact);
  }

  // To Entity List
  static List<DoctorEntity> toEntityList(List<DoctorApiModel> entityList) {
    return entityList.map((data) => data.toEntity()).toList();
  }

  // From entity list
  static List<DoctorApiModel> fromEntityList(List<DoctorEntity> entityList) {
    return entityList
        .map((entity) => DoctorApiModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => [name, specialization, contact];
}
