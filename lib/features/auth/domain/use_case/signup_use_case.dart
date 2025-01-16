import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myasteer/app/useccase/usecase.dart';
import 'package:myasteer/core/error/failure.dart';
import 'package:myasteer/features/auth/domain/entity/auth_entity.dart';
import 'package:myasteer/features/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String? userId;
  final String email;
  final String fname;
  final String lname;
  final String password;

  const RegisterUserParams({
    this.userId,
    required this.email,
    required this.fname,
    required this.lname,
    required this.password,
  });

  //intial constructor
  const RegisterUserParams.initial({
    this.userId,
    required this.email,
    required this.fname,
    required this.lname,
    required this.password,
  });

  @override
  List<Object?> get props => [userId, email, fname, lname, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      userId: params.userId,
      email: params.email,
      fName: params.fname,
      password: params.password,
    );
    return repository.registerUser(authEntity);
  }
}
