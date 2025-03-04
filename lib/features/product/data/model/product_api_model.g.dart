// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductApiModel _$ProductApiModelFromJson(Map<String, dynamic> json) =>
    ProductApiModel(
      id: json['_id'] as String?,
      name: json['name'] as String,
      image: json['image'] as String,
      manufacturer: json['manufacturer'] as String,
      genericName: json['genericName'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$ProductApiModelToJson(ProductApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'genericName': instance.genericName,
      'manufacturer': instance.manufacturer,
    };
