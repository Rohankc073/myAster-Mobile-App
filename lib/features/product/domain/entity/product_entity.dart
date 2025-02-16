import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? id;
  final String name;
  final double price;
  final String manufacturer;
  final double quantity;
  final bool? requiresPrescription;
  final String description;
  final String image;
  final String? dosage;
  final String? category;

  const ProductEntity(
      {this.id,
      required this.name,
      required this.price,
      required this.manufacturer,
      required this.quantity,
      this.requiresPrescription,
      required this.description,
      required this.image,
      this.category,
      this.dosage});

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        manufacturer,
        price,
        quantity,
        dosage,
        requiresPrescription,
        category,
        image,
        description
      ];
}
