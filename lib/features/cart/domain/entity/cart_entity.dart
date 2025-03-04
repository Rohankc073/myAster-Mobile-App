import 'package:equatable/equatable.dart';
import 'package:myAster/features/cart/domain/entity/cart_item_entity.dart';

class CartEntity extends Equatable {
  final String userId;
  final List<CartItemEntity> items;

  const CartEntity({
    required this.userId,
    required this.items,
  });

  const CartEntity.empty()
      : userId = '',
        items = const [];

  @override
  List<Object?> get props => [userId, items];
}
