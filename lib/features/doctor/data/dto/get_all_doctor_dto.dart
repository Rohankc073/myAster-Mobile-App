import 'package:json_annotation/json_annotation.dart';
import 'package:myasteer/features/doctor/data/model/doctor_api_model.dart';

part 'get_all_doctor_dto.g.dart';

@JsonSerializable()
class GetAllDoctorDTO {
  final String id;
  final String name;
  final String specialization;
  final bool success;
  final int count;
  final List<DoctorApiModel> data;

  GetAllDoctorDTO({
    required this.id,
    required this.count,
    required this.data,
    required this.success,
    required this.name,
    required this.specialization,
  });

  Map<String, dynamic> toJson() => _$GetAllDoctorDTOToJson(this);

  factory GetAllDoctorDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllDoctorDTOFromJson(json);
}
