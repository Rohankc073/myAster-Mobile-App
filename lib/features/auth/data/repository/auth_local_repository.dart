import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:myAster/core/error/failure.dart';
import 'package:myAster/features/auth/data/datasource/local_data_source/local_data_source.dart';
import 'package:myAster/features/auth/domain/entity/auth_entity.dart';
import 'package:myAster/features/auth/domain/repository/auth_repository.dart';
import 'package:myAster/features/auth/domain/use_case/login_use_case.dart';

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepository(this._authLocalDataSource);

  // @override
  // Future<Either<Failure, AuthEntity>> getCurrentUser() async {
  //   try {
  //     final currentUser = await _authLocalDataSource.getCurrentUser();
  //     return Right(currentUser);
  //   } catch (e) {
  //     return Left(LocalDatabaseFailure(message: e.toString()));
  //   }
  // }

  @override
  Future<Either<Failure, AuthResponse>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final authResponse =
          await _authLocalDataSource.loginUser(email, password);
      return Right(AuthResponse(
          token: authResponse.token,
          userId: authResponse.userId,
          name: authResponse.name,
          email: authResponse.email,
          role: authResponse.role));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      return Right(_authLocalDataSource.registerUser(user));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
