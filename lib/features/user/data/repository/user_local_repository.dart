import 'package:dartz/dartz.dart';
import 'package:myAster/features/user/data/data_source/local_datasource/user_local_data_source.dart';
import 'package:myAster/features/user/domain/entity/user_entity.dart';
import 'package:myAster/features/user/domain/repository/doctor_repository.dart';

import '../../../../core/error/failure.dart';

class UserLocalRepository implements IUserRepository {
  final UserLocalDataSource _userLocalDataSource;

  UserLocalRepository({
    required UserLocalDataSource userLocalDataSource,
  }) : _userLocalDataSource = userLocalDataSource;

  // @override
  // Future<Either<Failure, void>> createDoctor(DoctorEntity user) async {
  //   try {
  //     await _userLocalDataSource.createDoctor(user);
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(LocalDatabaseFailure(message: 'Error creating user: $e'));
  //   }
  // }

  // @override
  // Future<Either<Failure, void>> deleteDoctor(String id, String? token) async {
  //   try {
  //     await _userLocalDataSource.deleteDoctor(id, token);
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(LocalDatabaseFailure(message: 'Error deleting user: $e'));
  //   }
  // }

  @override
  Future<Either<Failure, UserEntity>> getUserById(String id) async {
    try {
      final user = await _userLocalDataSource.getUserById(id);
      return Right(user);
    } catch (e) {
      return Left(
          LocalDatabaseFailure(message: 'Error fetching user by ID: $e'));
    }
  }

  // @override
  // Future<Either<Failure, void>> updateDoctor(
  //     DoctorEntity user, String? token) async {
  //   try {
  //     await _userLocalDataSource.updateDoctor(user);
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(LocalDatabaseFailure(message: 'Error updating user: $e'));
  //   }
  // }
}
