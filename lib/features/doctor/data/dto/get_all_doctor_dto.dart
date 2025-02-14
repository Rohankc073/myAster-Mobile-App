import 'package:json_annotation/json_annotation.dart';

part 'get_all_doctor_dto.g.dart';

@JsonSerializable()
class DoctorApiModel {
  final String id;
  final String name;
  final String specialization;

  DoctorApiModel({
    required this.id,
    required this.name,
    required this.specialization,
  });

  factory DoctorApiModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorApiModelToJson(this);
}
