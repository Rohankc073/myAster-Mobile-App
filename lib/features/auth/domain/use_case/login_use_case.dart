import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myasteer/app/useccase/usecase.dart';
import 'package:myasteer/core/error/failure.dart';
import 'package:myasteer/features/auth/domain/repository/auth_repository.dart';

class LoginUserParams extends Equatable {
  final String email;
  final String password;

  const LoginUserParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class LoginUseCase implements UsecaseWithParams<void, LoginUserParams> {
  final IAuthRepository authRepository;

  const LoginUseCase({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(LoginUserParams params) async {
    return await authRepository.loginUser(params.email, params.password);
  }
}
