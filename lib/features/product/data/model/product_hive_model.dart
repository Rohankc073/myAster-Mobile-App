import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myasteer/features/product/domain/entity/product_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';

part 'product_hive_model.g.dart';

// Command to Generate Adapter: dart run build_runner build -d
// Need to run each time changes are made to the model.

@HiveType(typeId: HiveTableConstant.productTableId)
class ProductHiveModel extends Equatable {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final double price;

  ProductHiveModel({
    String? id,
    required this.name,
    required this.image,
    required this.price,
  }) : id = id ?? const Uuid().v4();

  // Initial Constructor
  const ProductHiveModel.initial()
      : id = '',
        name = '',
        image = '',
        price = 0.0;
  // From Entity
  factory ProductHiveModel.fromEntity(ProductEntity entity) {
    return ProductHiveModel(
      id: entity.id,
      name: entity.name,
      image: entity.image,
      price: entity.price,
    );
  }

  // To Entity
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      image: image,
      price: price,
    );
  }

  // To Entity List
  static List<ProductHiveModel> fromEntityList(List<ProductEntity> entityList) {
    return entityList
        .map((entity) => ProductHiveModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        price,
      ];
}
