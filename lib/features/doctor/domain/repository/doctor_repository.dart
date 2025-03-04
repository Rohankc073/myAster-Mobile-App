import 'package:dartz/dartz.dart';
import 'package:myAster/features/doctor/domain/entity/doctor_entity.dart';

import '../../../../core/error/failure.dart';

abstract interface class IDoctorRepository {
  // Future<Either<Failure, void>> createDoctor(DoctorEntity doctorEntity);

  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors();

  // Future<Either<Failure, DoctorEntity>> getDoctorById(String id);

  // Future<Either<Failure, void>> updateDoctor(
  //     DoctorEntity doctorEntity, String? token);

  // Future<Either<Failure, void>> deleteDoctor(String id, String? token);
}
