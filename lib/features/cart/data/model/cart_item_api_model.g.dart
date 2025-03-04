// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemApiModel _$CartItemApiModelFromJson(Map<String, dynamic> json) =>
    CartItemApiModel(
      productId: json['_id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      quantity: json['quantity'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$CartItemApiModelToJson(CartItemApiModel instance) =>
    <String, dynamic>{
      '_id': instance.productId,
      'name': instance.name,
      'image': instance.image,
      'quantity': instance.quantity,
      'price': instance.price,
    };
