import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myasteer/features/doctor/domain/entity/doctor_entity.dart';

part 'doctor_api_model.g.dart';

// Include the generated part file.

@JsonSerializable()
class DoctorApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String? contact;
  final String? email;

  const DoctorApiModel({
    this.id,
    required this.name,
    this.contact,
    this.email,
  });

  const DoctorApiModel.empty()
      : id = '',
        name = '',
        contact = '',
        email = null;

  // From JSON
  factory DoctorApiModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorApiModelFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$DoctorApiModelToJson(this);

  // Convert API Object to Entity
  DoctorEntity toEntity() => DoctorEntity(
        id: id,
        name: name,
        contact: contact,
        email: email,
      );

  // Convert Entity to API Object
  factory DoctorApiModel.fromEntity(DoctorEntity doctor) {
    return DoctorApiModel(
      id: doctor.id,
      name: doctor.name,
      contact: doctor.contact,
      email: doctor.email,
    );
  }

  // Convert API List to Entity List
  static List<DoctorEntity> toEntityList(List<DoctorApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        contact,
      ];
}
