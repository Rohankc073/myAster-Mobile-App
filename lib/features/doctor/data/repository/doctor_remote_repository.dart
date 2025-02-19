import 'package:dartz/dartz.dart';
import 'package:myasteer/features/doctor/data/data_source/remote_datasource/doctor_remote_data_source.dart';
import 'package:myasteer/features/doctor/domain/entity/doctor_entity.dart';
import 'package:myasteer/features/doctor/domain/repository/doctor_repository.dart';

import '../../../../core/error/failure.dart';

class DoctorRemoteRepository implements IDoctorRepository {
  final DoctorRemoteDataSource _doctorRemoteDataSource;

  DoctorRemoteRepository({
    required DoctorRemoteDataSource doctorRemoteDataSource,
  }) : _doctorRemoteDataSource = doctorRemoteDataSource;

  // @override
  // Future<Either<Failure, void>> createDoctor(DoctorEntity doctor) async {
  //   try {
  //     await _doctorRemoteDataSource.createDoctor(doctor);
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(ApiFailure(message: 'Error creating doctor: $e'));
  //   }
  // }

  // @override
  // Future<Either<Failure, void>> deleteDoctor(String id, String? token) async {
  //   try {
  //     await _doctorRemoteDataSource.deleteDoctor(id, token);
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(ApiFailure(message: 'Error deleting doctor: $e'));
  //   }
  // }

  @override
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors() async {
    try {
      final categories = await _doctorRemoteDataSource.getAllDoctors();
      return Right(categories);
    } catch (e) {
      return Left(ApiFailure(message: 'Error fetching all categories: $e'));
    }
  }

  // @override
  // Future<Either<Failure, DoctorEntity>> getDoctorById(String id) async {
  //   try {
  //     final doctor = await _doctorRemoteDataSource.getDoctorById(id);
  //     return Right(doctor);
  //   } catch (e) {
  //     return Left(ApiFailure(message: 'Error fetching doctor by ID: $e'));
  //   }
  // }

  // @override
  // Future<Either<Failure, void>> updateDoctor(
  //     DoctorEntity doctor, String? token) async {
  //   try {
  //     await _doctorRemoteDataSource.updateDoctor(doctor);
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(ApiFailure(message: 'Error updating doctor: $e'));
  //   }
  // }
}
