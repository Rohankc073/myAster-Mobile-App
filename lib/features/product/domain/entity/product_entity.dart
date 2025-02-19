import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? id;
  final String name;
  // final String? email;
  // final String? contact;

  const ProductEntity({
    this.id,
    required this.name,
    // this.email,
    // this.contact,
  });

  // Initialize Empty Constructor
  const ProductEntity.empty()
      : id = '_empty.id',
        name = '_empty.name';
  // email = '_empty.email',
  // contact = '_empty.contact';

  @override
  List<Object?> get props => [
        id,
        name,
        // email,
        // contact,
      ];
}
