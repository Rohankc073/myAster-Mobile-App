part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object> get props => [];
}

class LoadCartEvent extends CartEvent {
  final String userId;
  const LoadCartEvent({required this.userId});
  @override
  List<Object> get props => [userId];
}

class AddProductToCartEvent extends CartEvent {
  final String productId;
  final String userId;
  final String productName;
  final double productPrice;
  final BuildContext context;

  const AddProductToCartEvent({
    required this.productId,
    required this.userId,
    required this.productName,
    required this.productPrice,
    required this.context,
  });
}

class RemoveProductFromCartEvent extends CartEvent {
  final String productId;
  final String userId;
  final String productName;
  final double productPrice;
  final int productQuantity;

  const RemoveProductFromCartEvent({
    required this.productId,
    required this.userId,
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
  });

  @override
  List<Object> get props =>
      [productId, userId, productName, productPrice, productQuantity];
}

class ClearCartEvent extends CartEvent {
  final String userId;
  const ClearCartEvent({required this.userId});
  @override
  List<Object> get props => [userId];
}
