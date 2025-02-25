import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myasteer/features/cart/domain/entity/cart_item_entity.dart';

part 'cart_item_api_model.g.dart';

@JsonSerializable()
class CartItemApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String productId;
  final String productName;
  final String productImage;

  // final int quantity;
  final double price;

  const CartItemApiModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    // required this.quantity,
    required this.price,
  });

  factory CartItemApiModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemApiModelToJson(this);

  // Convert API model to entity
  CartItemEntity toEntity() => CartItemEntity(
        productId: productId,
        productName: productName,
        productImage: productImage,
        productDescription: "productDescription",
        // quantity: quantity,
        price: price,
      );

  // Convert entity to API model
  static CartItemApiModel fromEntity(CartItemEntity entity) => CartItemApiModel(
        productId: entity.productId,
        productName: entity.productName,
        productImage: entity.productImage,
        // quantity: entity.quantity,
        price: entity.price,
      );

  @override
  List<Object?> get props => [
        productId,
        productName,
        productImage,
        // quantity,
        price,
      ];
}
