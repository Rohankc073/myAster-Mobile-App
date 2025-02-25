import 'package:dartz/dartz.dart';
import 'package:myasteer/core/error/failure.dart';
import 'package:myasteer/features/cart/domain/entity/cart_item_entity.dart';

abstract interface class ICartRepository {
  Future<Either<Failure, void>> addProductToCart(
    CartItemEntity product,
  );
  // Future<Either<Failure, void>> removeProductFromCart(
  //   CartItemEntity product,
  // );
  // Future<Either<Failure, void>> clearCart();
  // Future<Either<Failure, List<CartItemEntity>>> getCartProducts();
}
