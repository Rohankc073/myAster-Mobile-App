part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartItemEntity> items;
  final bool isLoading;
  final String? error;

  const CartState({
    required this.items,
    required this.isLoading,
    this.error,
  });

  factory CartState.initial() {
    return const CartState(
      items: [],
      isLoading: false,
      error: null,
    );
  }

  CartState copyWith({
    List<CartItemEntity>? items,
    bool? isLoading,
    String? error,
  }) {
    return CartState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [items, isLoading, error];
}
