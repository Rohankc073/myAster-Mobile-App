import 'package:dartz/dartz.dart';
import 'package:myAster/app/useccase/usecase.dart';
import 'package:myAster/features/product/domain/entity/product_entity.dart';
import 'package:myAster/features/product/domain/repository/product_repository.dart';

import '../../../../core/error/failure.dart';

class GetAllProductsUseCase
    implements UsecaseWithoutParams<List<ProductEntity>> {
  final IProductRepository productRepository;

  GetAllProductsUseCase({required this.productRepository});

  @override
  Future<Either<Failure, List<ProductEntity>>> call() {
    return productRepository.getAllProducts();
  }
}
