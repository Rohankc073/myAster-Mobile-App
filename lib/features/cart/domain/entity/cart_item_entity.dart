import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final String productId;
  final String name;
  final String image;
  final String description;
  final String quantity;
  final double price;

  const CartItemEntity({
    required this.productId,
    required this.name,
    required this.image,
    required this.description,
    required this.quantity,
    required this.price,
  });

//  productId: { type: mongoose.Schema.Types.ObjectId, ref: "Product", required: true },
//       name: { type: String, required: true }, // Product Name
//       price: { type: Number, required: true }, // Product Price
//       image: { type: String }, // Product Image URL
//       description: { type: String }, // Product Description
//       quantity:
  @override
  List<Object?> get props => [
        productId,
        name,
        image,
        description,
        quantity,
        price,
      ];
}
