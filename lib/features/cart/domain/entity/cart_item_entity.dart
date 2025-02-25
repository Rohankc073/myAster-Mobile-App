import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final String productId;
  final String productName;
  final String productImage;
  final String productDescription;
  // final int quantity;
  final double price;

  const CartItemEntity({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productDescription,
    // required this.quantity,
    required this.price,
  });

  @override
  List<Object?> get props => [
        productId,
        productName,
        productImage,
        productDescription,
        // quantity,
        price,
      ];
}
