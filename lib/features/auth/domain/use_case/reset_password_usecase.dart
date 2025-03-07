import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myAster/features/auth/domain/repository/auth_repository.dart';

import '../../../../../core/error/failure.dart';

class ResetPasswordParams extends Equatable {
  final String email;
  final String otp;
  final String newPassword;

  const ResetPasswordParams({
    required this.email,
    required this.otp,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [email, otp, newPassword];
}

class ResetPasswordUseCase {
  final IAuthRepository userRepository;

  const ResetPasswordUseCase({required this.userRepository});

  Future<Either<Failure, void>> call(ResetPasswordParams params) async {
    return await userRepository.resetPassword(
      params.otp,
      params.newPassword,
      params.email,
    );
  }
}
