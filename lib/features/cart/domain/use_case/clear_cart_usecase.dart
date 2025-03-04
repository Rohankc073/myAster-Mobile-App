import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myAster/app/useccase/usecase.dart';
import 'package:myAster/core/error/failure.dart';
import 'package:myAster/features/cart/domain/repository/cart_repository.dart';

class ClearCartParams extends Equatable {
  final String userId;

  const ClearCartParams({
    required this.userId,
  });

  @override
  List<Object?> get props => [
        userId,
      ];
}

class ClearCartUsecase implements UsecaseWithParams<void, ClearCartParams> {
  final ICartRepository _repository;

  ClearCartUsecase({required ICartRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, void>> call(ClearCartParams params) async {
    final result = await _repository.clearCart();

    return result;
  }
}
