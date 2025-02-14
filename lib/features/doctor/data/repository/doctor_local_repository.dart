import 'package:dartz/dartz.dart';
import 'package:myasteer/core/error/failure.dart';
import 'package:myasteer/features/doctor/data/data_source/local_datasource/doctor_local_datasource.dart';
import 'package:myasteer/features/doctor/domain/entity/doctor_entity.dart';
import 'package:myasteer/features/doctor/domain/repository/doctor_repository.dart';

class DoctorLocalRepository implements IDoctorRepository {
  final DoctorLocalDatasource _doctorLocalDataSource;

  DoctorLocalRepository({required DoctorLocalDatasource doctorLocalDataSource})
      : _doctorLocalDataSource = doctorLocalDataSource;

  @override
  Future<Either<Failure, void>> createDoctor(DoctorEntity doctor) {
    try {
      _doctorLocalDataSource.addDoctor(doctor);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors() {
    try {
      return _doctorLocalDataSource.getAllDoctor().then(
        (value) {
          return Right(value);
        },
      );
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteDoctor(String id) {
    try {
      _doctorLocalDataSource.deleteDoctor(id);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }
}
