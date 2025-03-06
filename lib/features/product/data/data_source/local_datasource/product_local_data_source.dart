import 'package:myAster/features/product/data/data_source/product_data_source.dart';
import 'package:myAster/features/product/data/model/product_hive_model.dart';
import 'package:myAster/features/product/domain/entity/product_entity.dart';

import '../../../../../core/network/hive_service.dart';

class ProductLocalDataSource implements IProductDataSource {
  final HiveService _hiveService;

  ProductLocalDataSource(this._hiveService);

  // @override
  // Future<void> createProduct(ProductEntity productEntity) async {
  //   try {
  //     final productHiveModel = ProductHiveModel.fromEntity(productEntity);
  //     await _hiveService.addProduct(productHiveModel);
  //   } catch (e) {
  //     throw Exception('Error creating product: $e');
  //   }
  // }

  // @override
  // Future<void> deleteProduct(String id, String? token) async {
  //   try {
  //     await _hiveService.deleteProduct(id);
  //   } catch (e) {
  //     throw Exception('Error deleting product: $e');
  //   }
  // }

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    try {
      final products = await _hiveService.getAllProduct();
      return products.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception('Error fetching all products: $e');
    }
  }

  @override
  Future<List<ProductHiveModel>> getProductById(String id) async {
    try {
      final productHiveModel = await _hiveService.getProductById();
      return productHiveModel;
    } catch (e) {
      throw Exception('Error fetching product by ID: $e');
    }
  }

  // @override
  // Future<void> updateProduct(ProductEntity productEntity) async {
  //   try {
  //     final productHiveModel = ProductHiveModel.fromEntity(productEntity);
  //     await _hiveService.updateProduct(productHiveModel);
  //   } catch (e) {
  //     throw Exception('Error updating product: $e');
  //   }
  // }
}
