import 'package:dartz/dartz.dart';
import 'package:myAster/features/user/data/data_source/remote_datasource/user_remote_data_source.dart';
import 'package:myAster/features/user/domain/entity/user_entity.dart';
import 'package:myAster/features/user/domain/repository/doctor_repository.dart';

import '../../../../core/error/failure.dart';

class UserRemoteRepository implements IUserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRemoteRepository({
    required UserRemoteDataSource userRemoteDataSource,
  }) : _userRemoteDataSource = userRemoteDataSource;

  // @override
  // Future<Either<Failure, void>> createUser(UserEntity user) async {
  //   try {
  //     await _userRemoteDataSource.createUser(user);
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(ApiFailure(message: 'Error creating user: $e'));
  //   }
  // }

  // @override
  // Future<Either<Failure, void>> deleteUser(String id, String? token) async {
  //   try {
  //     await _userRemoteDataSource.deleteUser(id, token);
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(ApiFailure(message: 'Error deleting user: $e'));
  //   }
  // }

  // @override
  // Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
  //   try {
  //     final categories = await _userRemoteDataSource.getAllUsers();
  //     return Right(categories);
  //   } catch (e) {
  //     return Left(ApiFailure(message: 'Error fetching all categories: $e'));
  //   }
  // }

  @override
  Future<Either<Failure, UserEntity>> getUserById(String id) async {
    try {
      final user = await _userRemoteDataSource.getUserById(id);
      return Right(user);
    } catch (e) {
      return Left(ApiFailure(message: 'Error fetching user by ID: $e'));
    }
  }

  // @override
  // Future<Either<Failure, void>> updateUser(
  //     UserEntity user, String? token) async {
  //   try {
  //     await _userRemoteDataSource.updateUser(user);
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(ApiFailure(message: 'Error updating user: $e'));
  //   }
  // }
}
