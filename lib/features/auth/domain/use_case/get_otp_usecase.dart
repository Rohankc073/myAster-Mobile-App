import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myAster/features/auth/domain/repository/auth_repository.dart';

import '../../../../../core/error/failure.dart';

class GetOtpParams extends Equatable {
  final String email;

  const GetOtpParams({required this.email});

  const GetOtpParams.empty() : email = '_empty.email';

  @override
  List<Object?> get props => [email];
}

class GetOtpUseCase {
  final IAuthRepository userRepository;

  const GetOtpUseCase({required this.userRepository});

  @override
  Future<Either<Failure, String>> call(GetOtpParams params) async {
    // Call the repository to login
    return userRepository.receiveOtp(params.email).then((value) {
      return value.fold(
        (failure) => Left(failure),
        (response) {
          return Right(response);
        },
      );
    });
  }
}
