import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? id;
  final String name;
  final String image;
  final double price;

  // final String? email;
  // final String? contact;

  const ProductEntity({
    this.id,
    required this.name,
    required this.image,
    required this.price,
    // this.email,
    // this.contact,
  });

  // Initialize Empty Constructor
  const ProductEntity.empty()
      : id = '_empty.id',
        image = '_empty.image',
        name = '_empty.name',
        price = 0.0;
  // email = '_empty.email',
  // contact = '_empty.contact';

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
