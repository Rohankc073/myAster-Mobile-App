import 'package:dartz/dartz.dart';
import 'package:myasteer/features/user/domain/entity/user_entity.dart';

import '../../../../core/error/failure.dart';

abstract interface class IUserRepository {
  // Future<Either<Failure, void>> createUser(UserEntity userEntity);

  // Future<Either<Failure, List<UserEntity>>> getAllUsers();

  Future<Either<Failure, UserEntity>> getUserById(String id);

  // Future<Either<Failure, void>> updateUser(
  //     UserEntity userEntity, String? token);

  // Future<Either<Failure, void>> deleteUser(String id, String? token);
}
