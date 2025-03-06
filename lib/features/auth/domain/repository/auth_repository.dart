import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:myAster/core/error/failure.dart';
import 'package:myAster/features/auth/domain/use_case/login_use_case.dart';

import '../entity/auth_entity.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> registerUser(AuthEntity user);

  Future<Either<Failure, AuthResponse>> loginUser(
      String email, String password);

  // Future<Either<Failure, AuthEntity>> getCurrentUser();

  Future<Either<Failure, String>> uploadProfilePicture(File file);

  Future<Either<Failure, String>> receiveOtp(String email);

  Future<Either<Failure, void>> resetPassword(
      String email, String newPassword, String otp);
}
