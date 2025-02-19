// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorApiModel _$DoctorApiModelFromJson(Map<String, dynamic> json) =>
    DoctorApiModel(
      id: json['_id'] as String?,
      name: json['name'] as String,
      contact: json['contact'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$DoctorApiModelToJson(DoctorApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'contact': instance.contact,
      'email': instance.email,
    };
