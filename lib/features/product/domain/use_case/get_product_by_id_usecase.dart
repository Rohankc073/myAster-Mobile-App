import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myAster/app/useccase/usecase.dart';
import 'package:myAster/core/error/failure.dart';
import 'package:myAster/features/product/domain/entity/product_entity.dart';
import 'package:myAster/features/product/domain/repository/product_repository.dart';

class GetProductByIdParams extends Equatable {
  final String productId;

  const GetProductByIdParams({required this.productId});

  @override
  List<Object?> get props => [productId];
}

class GetProductByIdUseCase
    implements UsecaseWithParams<ProductEntity, GetProductByIdParams> {
  final IProductRepository productRepository;

  GetProductByIdUseCase({required this.productRepository});

  @override
  Future<Either<Failure, ProductEntity>> call(
      GetProductByIdParams params) async {
    return productRepository.getProductById(params.productId);
  }
}
