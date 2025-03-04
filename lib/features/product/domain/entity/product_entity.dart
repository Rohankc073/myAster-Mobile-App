import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? id;
  final String name;
  final String image;
  final double price;
  final String description;
  final String genericName;
  final String manufacturer;

  // final String? email;
  // final String? contact;

  const ProductEntity({
    this.id,
    required this.name,
    required this.genericName,
    required this.manufacturer,
    required this.image,
    required this.price,
    required this.description,
    // this.email,
    // this.contact,
  });

  // Initialize Empty Constructor
  const ProductEntity.empty()
      : id = '_empty.id',
        image = '_empty.image',
        name = '_empty.name',
        price = 0.0,
        genericName = '_empty.genericName',
        manufacturer = '_empty.manufacturer',
        description = '_empty.description';

  // email = '_empty.email',
  // contact = '_empty.contact';

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        price,
        description,
        genericName,
        manufacturer
        // email,
        // contact,
      ];

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['_id'] ?? '',
      name: json['name'] ?? 'No Name',
      image: json['image'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      genericName: json['genericName'] ?? '',
      manufacturer: json['manufacturer'] ?? '',
    );
  }
}
