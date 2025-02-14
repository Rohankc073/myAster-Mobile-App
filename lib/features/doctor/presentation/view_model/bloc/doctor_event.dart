part of 'doctor_bloc.dart';

sealed class DoctorEvent extends Equatable {
  const DoctorEvent();

  @override
  List<Object> get props => [];
}

class DoctorLoad extends DoctorEvent {}

class CreateDoctor extends DoctorEvent {
  final String name;
  final String specialization;
  final String availableDays;
  final String availableTimes;
  final String contact;
  final String email;

  const CreateDoctor(
      {required this.name,
      required this.specialization,
      required this.availableDays,
      required this.availableTimes,
      required this.contact,
      required this.email});

  @override
  List<Object> get props =>
      [name, specialization, availableDays, availableTimes, contact, email];
}
