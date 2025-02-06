import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myasteer/app/useccase/usecase.dart';
import 'package:myasteer/core/error/failure.dart';
import 'package:myasteer/features/auth/domain/entity/auth_entity.dart';
import 'package:myasteer/features/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String? userId;
  final String? image;
  final String email;
  final String name;
  final String phone;
  final String password;

  const RegisterUserParams({
    this.userId,
    this.image,
    required this.email,
    required this.name,
    required this.phone,
    required this.password,
  });

  const RegisterUserParams.empty()
      : userId = '_empty.string',
        image = '_empyt.string',
        email = '_empty.string',
        name = '_empty.string',
        phone = '_empty.string',
        password = "_empty.string";

  //intial constructor
  const RegisterUserParams.initial({
    this.userId,
    this.image,
    required this.email,
    required this.name,
    required this.phone,
    required this.password,
  });

  @override
  List<Object?> get props => [userId, email, name, phone, password, image];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository userRepository;

  RegisterUseCase(this.userRepository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) async {
    final authEntity = AuthEntity(
      userId: params.userId,
      image: params.image,
      email: params.email,
      name: params.name,
      phone: params.phone,
      password: params.password,
    );
    return await userRepository.registerUser(authEntity);
  }
}
