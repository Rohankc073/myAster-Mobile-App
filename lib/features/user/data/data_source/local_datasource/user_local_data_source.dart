import 'package:myasteer/features/user/data/data_source/user_data_source.dart';
import 'package:myasteer/features/user/domain/entity/user_entity.dart';

import '../../../../../core/network/hive_service.dart';

class UserLocalDataSource implements IUserDataSource {
  final HiveService _hiveService;

  UserLocalDataSource(this._hiveService);

  @override
  Future<UserEntity> getUserById(String id) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  // @override
  // Future<void> createUser(UserEntity userEntity) async {
  //   try {
  //     final userHiveModel = UserHiveModel.fromEntity(userEntity);
  //     await _hiveService.addUser(userHiveModel);
  //   } catch (e) {
  //     throw Exception('Error creating user: $e');
  //   }
  // }

  // @override
  // Future<void> deleteUser(String id, String? token) async {
  //   try {
  //     await _hiveService.deleteUser(id);
  //   } catch (e) {
  //     throw Exception('Error deleting user: $e');
  //   }
  // }

  // @override
  // Future<List<UserEntity>> getAllUsers() async {
  //   try {
  //     final users = await _hiveService.getAllUser();
  //     return users.map((e) => e.toEntity()).toList();
  //   } catch (e) {
  //     throw Exception('Error fetching all users: $e');
  //   }
  // }

  // @override
  // Future<UserEntity> getUserById(String id) async {
  //   try {
  //     final userHiveModel = await _hiveService.getUserById(id);
  //     if (userHiveModel != null) {
  //       return userHiveModel.toEntity();
  //     } else {
  //       throw Exception('User not found');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching user by ID: $e');
  //   }
  // }

  // @override
  // Future<void> updateUser(UserEntity userEntity) async {
  //   try {
  //     final userHiveModel = UserHiveModel.fromEntity(userEntity);
  //     await _hiveService.updateUser(userHiveModel);
  //   } catch (e) {
  //     throw Exception('Error updating user: $e');
  //   }
  // }
}
