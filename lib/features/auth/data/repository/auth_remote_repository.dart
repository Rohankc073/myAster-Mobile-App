import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:myAster/core/error/failure.dart';
import 'package:myAster/features/auth/data/datasource/remote_data_source/remote_data_source.dart';
import 'package:myAster/features/auth/domain/entity/auth_entity.dart';
import 'package:myAster/features/auth/domain/repository/auth_repository.dart';
import 'package:myAster/features/auth/domain/use_case/login_use_case.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository(this._authRemoteDataSource);

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthResponse>> loginUser(
      String userName, String password) async {
    try {
      final authResponse =
          await _authRemoteDataSource.loginUser(userName, password);
      return Right(authResponse);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      await _authRemoteDataSource.registerUser(user);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      return Right(await _authRemoteDataSource.uploadProfilePicture(file));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
