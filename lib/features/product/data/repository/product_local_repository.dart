import 'package:dartz/dartz.dart';
import 'package:myAster/features/product/data/data_source/local_datasource/product_local_data_source.dart';
import 'package:myAster/features/product/domain/entity/product_entity.dart';
import 'package:myAster/features/product/domain/repository/product_repository.dart';

import '../../../../core/error/failure.dart';

class ProductLocalRepository implements IProductRepository {
  final ProductLocalDataSource _productLocalDataSource;

  ProductLocalRepository({
    required ProductLocalDataSource productLocalDataSource,
  }) : _productLocalDataSource = productLocalDataSource;

  // @override
  // Future<Either<Failure, void>> createProduct(ProductEntity product) async {
  //   try {
  //     await _productLocalDataSource.createProduct(product);
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(LocalDatabaseFailure(message: 'Error creating product: $e'));
  //   }
  // }

  // @override
  // Future<Either<Failure, void>> deleteProduct(String id, String? token) async {
  //   try {
  //     await _productLocalDataSource.deleteProduct(id, token);
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(LocalDatabaseFailure(message: 'Error deleting product: $e'));
  //   }
  // }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String id) async {
    try {
      final productList = await _productLocalDataSource.getProductById(id);
      if (productList.isNotEmpty) {
        final product = productList.first.toEntity();
        return Right(product);
      } else {
        return const Left(LocalDatabaseFailure(message: 'Product not found'));
      }
    } catch (e) {
      return Left(
          LocalDatabaseFailure(message: 'Error fetching product by ID: $e'));
    }
  }

  // @override
  // Future<Either<Failure, void>> updateProduct(
  //     ProductEntity product, String? token) async {
  //   try {
  //     await _productLocalDataSource.updateProduct(product);
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(LocalDatabaseFailure(message: 'Error updating product: $e'));
  //   }
  // }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    try {
      final categories = await _productLocalDataSource.getAllProducts();
      return Right(categories);
    } catch (e) {
      return Left(
          LocalDatabaseFailure(message: 'Error fetching all categories: $e'));
    }
  }
}
