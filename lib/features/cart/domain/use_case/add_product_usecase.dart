import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myAster/app/useccase/usecase.dart';
import 'package:myAster/core/error/failure.dart';
import 'package:myAster/features/cart/domain/entity/cart_item_entity.dart';
import 'package:myAster/features/cart/domain/repository/cart_repository.dart';

class AddProductParams extends Equatable {
  final String productId;
  final String userId;
  final String name;

  final double price;
  final String quantity;

  const AddProductParams(
      {required this.productId,
      required this.userId,
      required this.name,
      required this.price,
      required this.quantity});

  @override
  List<Object?> get props => [productId, userId, quantity];
}

class AddProductUsecase implements UsecaseWithParams<void, AddProductParams> {
  final ICartRepository _repository;

  AddProductUsecase({required ICartRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, void>> call(AddProductParams params) async {
    final result = await _repository.addProductToCart(
      CartItemEntity(
        productId: params.productId,
        name: params.name,
        image: '',
        description: '',
        quantity: '',
        price: params.price,
      ),
    );

    return result;
  }
}
