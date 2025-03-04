import 'package:dartz/dartz.dart';
import 'package:myAster/features/product/domain/entity/product_entity.dart';

import '../../../../core/error/failure.dart';

abstract interface class IProductRepository {
  // Future<Either<Failure, void>> createProduct(ProductEntity productEntity);

  Future<Either<Failure, List<ProductEntity>>> getAllProducts();

  Future<Either<Failure, ProductEntity>> getProductById(String id);

  // Future<Either<Failure, void>> updateProduct(
  //     ProductEntity productEntity, String? token);

  // Future<Either<Failure, void>> deleteProduct(String id, String? token);
}
