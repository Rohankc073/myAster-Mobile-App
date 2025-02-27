import 'package:dartz/dartz.dart';
import 'package:myasteer/features/product/data/data_source/remote_datasource/product_remote_data_source.dart';
import 'package:myasteer/features/product/domain/entity/product_entity.dart';
import 'package:myasteer/features/product/domain/repository/product_repository.dart';

import '../../../../core/error/failure.dart';

class ProductRemoteRepository implements IProductRepository {
  final ProductRemoteDataSource _productRemoteDataSource;

  ProductRemoteRepository({
    required ProductRemoteDataSource productRemoteDataSource,
  }) : _productRemoteDataSource = productRemoteDataSource;

  // @override
  // Future<Either<Failure, void>> createProduct(ProductEntity product) async {
  //   try {
  //     await _productRemoteDataSource.createProduct(product);
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(ApiFailure(message: 'Error creating product: $e'));
  //   }
  // }

  // @override
  // Future<Either<Failure, void>> deleteProduct(String id, String? token) async {
  //   try {
  //     await _productRemoteDataSource.deleteProduct(id, token);
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(ApiFailure(message: 'Error deleting product: $e'));
  //   }
  // }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    try {
      final categories = await _productRemoteDataSource.getAllProducts();
      return Right(categories);
    } catch (e) {
      return Left(ApiFailure(message: 'Error fetching all categories: $e'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String id) async {
    try {
      final product = await _productRemoteDataSource.getProductById(id);
      return Right(product);
    } catch (e) {
      return Left(ApiFailure(message: 'Error fetching product by ID: $e'));
    }
  }

  // @override
  // Future<Either<Failure, void>> updateProduct(
  //     ProductEntity product, String? token) async {
  //   try {
  //     await _productRemoteDataSource.updateProduct(product);
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(ApiFailure(message: 'Error updating product: $e'));
  //   }
  // }
}
