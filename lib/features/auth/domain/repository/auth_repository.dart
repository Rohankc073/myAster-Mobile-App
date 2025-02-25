import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:myasteer/core/error/failure.dart';
import 'package:myasteer/features/auth/domain/use_case/login_use_case.dart';

import '../entity/auth_entity.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> registerUser(AuthEntity user);

  Future<Either<Failure, AuthResponse>> loginUser(
      String email, String password);

  // Future<Either<Failure, AuthEntity>> getCurrentUser();

  Future<Either<Failure, String>> uploadProfilePicture(File file);
}
