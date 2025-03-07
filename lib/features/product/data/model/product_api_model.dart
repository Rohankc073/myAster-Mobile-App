import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myAster/features/product/domain/entity/product_entity.dart';

part 'product_api_model.g.dart';

// Include the generated part file.

@JsonSerializable()
class ProductApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String image;
  final double price;
  final String genericName;
  final String manufacturer;

  const ProductApiModel({
    this.id,
    required this.name,
    required this.image,
    required this.manufacturer,
    required this.genericName,
    required this.price,
    // this.contact,
    // this.email,
  });

  const ProductApiModel.empty(this.genericName, this.manufacturer)
      : id = '',
        name = '',
        image = '',
        price = 0.0;

  // contact = '',
  // email = null;

  // From JSON
  factory ProductApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProductApiModelFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$ProductApiModelToJson(this);

  // Convert API Object to Entity
  ProductEntity toEntity() => ProductEntity(
        id: id,
        name: name,
        price: price,
        image: image, genericName: '', manufacturer: '', description: '',
        // contact: contact,
        // email: email,
      );

  // Convert Entity to API Object
  factory ProductApiModel.fromEntity(ProductEntity product) {
    return ProductApiModel(
      id: product.id,
      name: product.name,
      price: product.price,
      image: product.image, manufacturer: product.manufacturer,
      genericName: product.genericName,
      // contact: product.contact,
      // email: product.email,
    );
  }

  // Convert API List to Entity List
  static List<ProductEntity> toEntityList(List<ProductApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        price,
        // email,
        // contact,
      ];
}
