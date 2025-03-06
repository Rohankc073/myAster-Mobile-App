import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myAster/app/useccase/usecase.dart';
import 'package:myAster/features/user/domain/entity/user_entity.dart';
import 'package:myAster/features/user/domain/repository/doctor_repository.dart';

import '../../../../core/error/failure.dart';

class GetUserByIdParams extends Equatable {
  final String id;

  const GetUserByIdParams({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetUserByIdUseCase
    implements UsecaseWithParams<UserEntity, GetUserByIdParams> {
  final IUserRepository userRepository;

  GetUserByIdUseCase({required this.userRepository});

  @override
  Future<Either<Failure, UserEntity>> call(GetUserByIdParams params) async {
    return userRepository.getUserById(params.id);
  }
}
