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
  final String name;
  final double price;
  final String quantity;

  const AddProductToCartEvent({
    required this.productId,
    required this.userId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  @override
  List<Object> get props => [productId, userId, name, price, quantity];
}

class RemoveProductFromCartEvent extends CartEvent {
  final String productId;
  final String userId;
  final String name;
  final double price;
  final String quantity;

  const RemoveProductFromCartEvent({
    required this.productId,
    required this.userId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  @override
  List<Object> get props => [productId, userId, name, price, quantity];
}

class ClearCartEvent extends CartEvent {
  final String userId;
  const ClearCartEvent({required this.userId});
  @override
  List<Object> get props => [userId];
}
