import 'package:myasteer/features/product/domain/entity/product_entity.dart';

abstract interface class IProductDataSource {
  Future<List<ProductEntity>> getAllProducts();

  Future<ProductEntity> getProductsById(String productId);

  Future<void> updateProduct(ProductEntity productEntity);

  Future<void> deleteProduct(String productId, String? token);
}
