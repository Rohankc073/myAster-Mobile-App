import 'package:myasteer/features/product/domain/entity/product_entity.dart';

abstract interface class IProductDataSource {
  // Future<void> createProduct(ProductEntity productEntity);

  Future<List<ProductEntity>> getAllProducts();

  // Future<ProductEntity> getProductById(String id);

  // Future<void> updateProduct(ProductEntity productEntity);

  // Future<void> deleteProduct(String id, String? token);
}
