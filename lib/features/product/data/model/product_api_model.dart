import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myasteer/features/product/domain/entity/product_entity.dart';

part 'product_api_model.g.dart';

// Include the generated part file.

@JsonSerializable()
class ProductApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  // final String? contact;
  // final String? email;

  const ProductApiModel({
    this.id,
    required this.name,
    // this.contact,
    // this.email,
  });

  const ProductApiModel.empty()
      : id = '',
        name = '';
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
        // contact: contact,
        // email: email,
      );

  // Convert Entity to API Object
  factory ProductApiModel.fromEntity(ProductEntity product) {
    return ProductApiModel(
      id: product.id,
      name: product.name,
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
        // email,
        // contact,
      ];
}
