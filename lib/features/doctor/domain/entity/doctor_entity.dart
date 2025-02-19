import 'package:equatable/equatable.dart';

class DoctorEntity extends Equatable {
  final String? id;
  final String name;
  final String? email;
  final String? contact;
  final String image;

  const DoctorEntity({
    this.id,
    required this.image,
    required this.name,
    this.email,
    this.contact,
  });

  // Initialize Empty Constructor
  const DoctorEntity.empty()
      : id = '_empty.id',
        image = '_empty.image',
        name = '_empty.name',
        email = '_empty.email',
        contact = '_empty.contact';

  @override
  List<Object?> get props => [
        id,
        image,
        name,
        email,
        contact,
      ];
}
