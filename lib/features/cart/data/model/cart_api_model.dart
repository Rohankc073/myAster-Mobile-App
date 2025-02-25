import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myasteer/features/cart/data/model/cart_item_api_model.dart';
import 'package:myasteer/features/cart/domain/entity/cart_entity.dart';

part 'cart_api_model.g.dart';

@JsonSerializable()
class CartApiModel extends Equatable {
  final String userId;
  final List<CartItemApiModel> items;
  const CartApiModel({
    required this.userId,
    required this.items,
  });

  factory CartApiModel.fromJson(Map<String, dynamic> json) =>
      _$CartApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartApiModelToJson(this);

  // Convert API model to entity
  CartEntity toEntity() => CartEntity(
        userId: userId,
        items: items.map((e) => e.toEntity()).toList(),
      );

  // Convert entity to API model
  static CartApiModel fromEntity(CartEntity entity) => CartApiModel(
        userId: entity.userId,
        items: entity.items.map((e) => CartItemApiModel.fromEntity(e)).toList(),
      );

  @override
  List<Object?> get props => [userId, items];
}
