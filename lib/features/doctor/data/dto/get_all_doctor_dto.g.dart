// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_doctor_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllDoctorDTO _$GetAllDoctorDTOFromJson(Map<String, dynamic> json) =>
    GetAllDoctorDTO(
      id: json['id'] as String,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => DoctorApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool,
      name: json['name'] as String,
      specialization: json['specialization'] as String,
    );

Map<String, dynamic> _$GetAllDoctorDTOToJson(GetAllDoctorDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'specialization': instance.specialization,
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
