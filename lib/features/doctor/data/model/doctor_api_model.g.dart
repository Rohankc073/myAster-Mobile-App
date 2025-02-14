// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorApiModel _$DoctorApiModelFromJson(Map<String, dynamic> json) =>
    DoctorApiModel(
      id: json['_id'] as String?,
      name: json['name'] as String,
      specialization: json['specialization'] as String,
      availableDays: json['availableDays'] as String,
      availableTimes: json['availableTimes'] as String,
      contact: json['contact'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$DoctorApiModelToJson(DoctorApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'specialization': instance.specialization,
      'availableDays': instance.availableDays,
      'availableTimes': instance.availableTimes,
      'contact': instance.contact,
      'email': instance.email,
    };
