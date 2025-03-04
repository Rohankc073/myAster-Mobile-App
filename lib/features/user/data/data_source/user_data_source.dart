import 'package:myAster/features/user/domain/entity/user_entity.dart';

abstract interface class IUserDataSource {
  // Future<void> createUser(UserEntity userEntity);

  // Future<List<UserEntity>> getAllUsers();

  Future<UserEntity> getUserById(String id);

  // Future<void> updateUser(UserEntity userEntity);

  // Future<void> deleteUser(String id, String? token);
}
