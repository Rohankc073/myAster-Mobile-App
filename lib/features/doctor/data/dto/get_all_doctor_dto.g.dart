// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_doctor_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorApiModel _$DoctorApiModelFromJson(Map<String, dynamic> json) =>
    DoctorApiModel(
      id: json['id'] as String,
      name: json['name'] as String,
      specialization: json['specialization'] as String,
    );

Map<String, dynamic> _$DoctorApiModelToJson(DoctorApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'specialization': instance.specialization,
    };
