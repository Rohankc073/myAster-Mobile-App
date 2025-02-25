// import 'package:ailav/app/usecase/usecase.dart';
// import 'package:ailav/core/error/failure.dart';
// import 'package:ailav/features/cart/domain/entity/cart_item_entity.dart';
// import 'package:ailav/features/cart/domain/repository/cart_repository.dart';
// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';

// class RemoveProductParams extends Equatable {
//   final String productId;
//   final String userId;
//   final String productName;

//   final double productPrice;
//   final int productQuantity;

//   const RemoveProductParams(
//       {required this.productId,
//       required this.userId,
//       required this.productName,
//       required this.productPrice,
//       required this.productQuantity});

//   @override
//   List<Object?> get props => [productId, userId, productQuantity];
// }

// class RemoveProductUsecase
//     implements UsecaseWithParams<void, RemoveProductParams> {
//   final ICartRepository _repository;

//   RemoveProductUsecase({required ICartRepository repository})
//       : _repository = repository;

//   @override
//   Future<Either<Failure, void>> call(RemoveProductParams params) async {
//     final result = await _repository.removeProductFromCart(
//       CartItemEntity(
//         productId: params.productId,
//         productName: params.productName,
//         productImage: '',
//         productDescription: '',
//         quantity: params.productQuantity,
//         price: params.productPrice,
//       ),
//     );

//     return result;
//   }
// }
