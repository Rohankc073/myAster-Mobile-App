import 'package:dartz/dartz.dart';
import 'package:myasteer/features/doctor/data/data_source/local_datasource/doctor_local_data_source.dart';
import 'package:myasteer/features/doctor/domain/entity/doctor_entity.dart';
import 'package:myasteer/features/doctor/domain/repository/doctor_repository.dart';

import '../../../../core/error/failure.dart';

class DoctorLocalRepository implements IDoctorRepository {
  final DoctorLocalDataSource _doctorLocalDataSource;

  DoctorLocalRepository({
    required DoctorLocalDataSource doctorLocalDataSource,
  }) : _doctorLocalDataSource = doctorLocalDataSource;

  // @override
  // Future<Either<Failure, void>> createDoctor(DoctorEntity doctor) async {
  //   try {
  //     await _doctorLocalDataSource.createDoctor(doctor);
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(LocalDatabaseFailure(message: 'Error creating doctor: $e'));
  //   }
  // }

  // @override
  // Future<Either<Failure, void>> deleteDoctor(String id, String? token) async {
  //   try {
  //     await _doctorLocalDataSource.deleteDoctor(id, token);
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(LocalDatabaseFailure(message: 'Error deleting doctor: $e'));
  //   }
  // }

  // @override
  // Future<Either<Failure, DoctorEntity>> getDoctorById(String id) async {
  //   try {
  //     final doctor = await _doctorLocalDataSource.getDoctorById(id);
  //     return Right(doctor);
  //   } catch (e) {
  //     return Left(
  //         LocalDatabaseFailure(message: 'Error fetching doctor by ID: $e'));
  //   }
  // }

  // @override
  // Future<Either<Failure, void>> updateDoctor(
  //     DoctorEntity doctor, String? token) async {
  //   try {
  //     await _doctorLocalDataSource.updateDoctor(doctor);
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(LocalDatabaseFailure(message: 'Error updating doctor: $e'));
  //   }
  // }

  @override
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors() async {
    try {
      final categories = await _doctorLocalDataSource.getAllDoctors();
      return Right(categories);
    } catch (e) {
      return Left(
          LocalDatabaseFailure(message: 'Error fetching all categories: $e'));
    }
  }
}
