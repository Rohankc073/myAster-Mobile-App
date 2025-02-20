// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApiModel _$UserApiModelFromJson(Map<String, dynamic> json) => UserApiModel(
      id: json['_id'] as String?,
      name: json['name'] as String,
      contact: json['contact'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String,
      specialization: json['specialization'] as String,
    );

Map<String, dynamic> _$UserApiModelToJson(UserApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'contact': instance.contact,
      'email': instance.email,
      'image': instance.image,
      'specialization': instance.specialization,
    };
