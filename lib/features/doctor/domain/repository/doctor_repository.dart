import 'package:dartz/dartz.dart';
import 'package:myasteer/core/error/failure.dart';
import 'package:myasteer/features/doctor/domain/entity/doctor_entity.dart';

abstract interface class IDoctorRepository {
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors();
  Future<Either<Failure, void>> deleteDoctor(String id);
  Future<Either<Failure, void>> createDoctor(DoctorEntity doctorEntity);
  // Add other methods as needed
}
