part of 'doctor_bloc.dart';

sealed class DoctorEvent extends Equatable {
  const DoctorEvent();

  @override
  List<Object?> get props => [];
}

final class LoadDoctors extends DoctorEvent {}

final class LoadDoctor extends DoctorEvent {}

final class AddDoctor extends DoctorEvent {
  final String name;
  final String? description;
  final String? photo;

  const AddDoctor(
      {required this.name, required this.description, required this.photo});

  @override
  List<Object?> get props => [name, description, photo];
}

final class DeleteDoctor extends DoctorEvent {
  final String id;

  const DeleteDoctor({required this.id});

  @override
  List<Object?> get props => [id];
}

final class UpdateDoctor extends DoctorEvent {
  final String id;
  final String name;
  final String? description;
  final String? photo;

  const UpdateDoctor({
    required this.id,
    required this.name,
    this.description,
    this.photo,
  });

  @override
  List<Object?> get props => [id, name, description, photo];
}
