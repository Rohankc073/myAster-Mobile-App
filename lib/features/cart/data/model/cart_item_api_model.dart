import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myAster/features/cart/domain/entity/cart_item_entity.dart';

part 'cart_item_api_model.g.dart';

@JsonSerializable()
class CartItemApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String productId;
  final String name;
  final String image;

  final String quantity;
  final double price;

  const CartItemApiModel({
    required this.productId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
  });

  factory CartItemApiModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemApiModelToJson(this);

  // Convert API model to entity
  CartItemEntity toEntity() => CartItemEntity(
        productId: productId,
        name: name,
        image: image,
        description: "productDescription",
        quantity: quantity,
        price: price,
      );

  // Convert entity to API model
  static CartItemApiModel fromEntity(CartItemEntity entity) => CartItemApiModel(
        productId: entity.productId,
        name: entity.name,
        image: entity.image,
        quantity: entity.quantity,
        price: entity.price,
      );

  @override
  List<Object?> get props => [
        productId,
        name,
        image,
        quantity,
        price,
      ];
}
