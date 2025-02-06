import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myasteer/app/shared_prefs/token_shared_prefs.dart';
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
  List<Object?> get props => [
        email,
        password,
      ];
}

// class LoginStudentUsecase
//     implements UsecaseWithParams<void, LoginStudentParams> {
//   final IAuthRepository authRepository;

//   const LoginStudentUsecase({required this.authRepository});

//   @override
//   Future<Either<Failure, void>> call(LoginStudentParams params) async {
//     return await authRepository.loginUser(params.email, params.password);
//   }
// }

class LoginUseCase implements UsecaseWithParams<void, LoginUserParams> {
  final IAuthRepository authRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  LoginUseCase({required this.authRepository, required this.tokenSharedPrefs});

  @override
  Future<Either<Failure, void>> call(LoginUserParams params) {
    //save token in shared preferences
    return authRepository
        .loginUser(params.email, params.password)
        .then((value) {
      return value.fold(
        (failure) => left(failure),
        (token) {
          tokenSharedPrefs.saveToken(token);
          // tokenSharedPrefs.getToken().then((value) {
          //   print(value);
          // });
          return Right(token);
        },
      );
    });
  }
}
