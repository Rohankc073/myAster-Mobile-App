import 'package:equatable/equatable.dart';

class DoctorEntity extends Equatable {
  final String? id;
  final String name;
  final String specialization;
  final String availableDays;
  final String availableTimes;
  final String contact;
  final String email;

  const DoctorEntity({
    this.id,
    required this.name,
    required this.specialization,
    required this.availableDays,
    required this.availableTimes,
    required this.contact,
    required this.email,
  });

  @override
  List<Object?> get props =>
      [id, name, specialization, availableDays, availableTimes, contact, email];
}
