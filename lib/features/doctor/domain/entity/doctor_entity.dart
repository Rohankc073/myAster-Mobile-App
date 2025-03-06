import 'package:equatable/equatable.dart';

class DoctorEntity extends Equatable {
  final String? id;
  final String name;
  final String? email;
  final String? contact;
  final String image;
  final String specialization;

  const DoctorEntity({
    this.id,
    required this.image,
    required this.name,
    required this.specialization,
    this.email,
    this.contact,
  });

  // Initialize Empty Constructor
  const DoctorEntity.empty()
      : id = '_empty.id',
        image = '_empty.image',
        name = '_empty.name',
        email = '_empty.email',
        specialization = '_empty.speciality',
        contact = '_empty.contact';

  @override
  List<Object?> get props => [id, image, name, email, contact, specialization];
}
