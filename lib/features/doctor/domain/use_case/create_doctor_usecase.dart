import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myasteer/app/useccase/usecase.dart';
import 'package:myasteer/core/error/failure.dart';
import 'package:myasteer/features/doctor/domain/entity/doctor_entity.dart';
import 'package:myasteer/features/doctor/domain/repository/doctor_repository.dart';

class CreateDoctorParams extends Equatable {
  final String name;
  final String specialization;
  final String availableDays;
  final String availableTimes;
  final String contact;
  final String email;

  const CreateDoctorParams(
      {required this.name,
      required this.specialization,
      required this.availableDays,
      required this.availableTimes,
      required this.contact,
      required this.email});

  // Empty constructor
  const CreateDoctorParams.empty()
      : name = '_empty.string',
        specialization = '_empty.string',
        availableDays = '_empty.string',
        availableTimes = '_empty.string',
        contact = '_empty.string',
        email = '_empty.string';

  @override
  List<Object?> get props =>
      [name, specialization, availableDays, availableTimes, contact, email];
}

class CreateDoctorUsecase
    implements UsecaseWithParams<void, CreateDoctorParams> {
  final IDoctorRepository _doctorRepository;

  CreateDoctorUsecase({required IDoctorRepository doctorRepository})
      : _doctorRepository = doctorRepository;

  @override
  Future<Either<Failure, void>> call(CreateDoctorParams params) {
    return _doctorRepository.createDoctor(
      DoctorEntity(
          name: params.name,
          specialization: params.specialization,
          availableDays: params.availableDays,
          availableTimes: params.availableTimes,
          contact: params.contact,
          email: params.email),
    );
  }
}
