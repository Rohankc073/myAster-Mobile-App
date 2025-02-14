import 'package:dartz/dartz.dart';
import 'package:myasteer/core/error/failure.dart';
import 'package:myasteer/features/doctor/domain/entity/doctor_entity.dart';
import 'package:myasteer/features/doctor/domain/repository/doctor_repository.dart';

class DoctorRemoteRepository implements IDoctorRepository {
  final DoctorRemoteRepository _doctorRemoteDataSource;

  DoctorRemoteRepository(this._doctorRemoteDataSource);

  // @override
  // Future<Either<Failure, void>> createCourse(CourseEntity course) async {
  //   try {
  //     await _courseRemoteDataSource.createCourse(course);
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(ApiFailure(message: e.toString()));
  //   }
  // }

  // @override
  // Future<Either<Failure, void>> deleteCourse(String id) {
  //   // TODO: implement deleteCourse
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<Failure, List<CourseEntity>>> getCourses() async {
  //   try {
  //     final courses = await _courseRemoteDataSource.getCourses();
  //     return Right(courses);
  //   } catch (e) {
  //     return Left(ApiFailure(message: e.toString()));
  //   }
  // }

  @override
  Future<Either<Failure, void>> createDoctor(DoctorEntity doctor) async {
    try {
      await _doctorRemoteDataSource.createDoctor(doctor);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteDoctor(String id) {
    // TODO: implement deleteDoctor
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors() {
    // TODO: implement getAllDoctors
    throw UnimplementedError();
  }
}
