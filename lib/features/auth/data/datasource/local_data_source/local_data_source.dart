import 'dart:io';

import 'package:myasteer/core/network/hive_service.dart';
import 'package:myasteer/features/auth/data/datasource/auth_data_source.dart';
import 'package:myasteer/features/auth/data/model/auth_hive_model.dart';
import 'package:myasteer/features/auth/domain/entity/auth_entity.dart';

class AuthLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDataSource(this._hiveService);

  @override
  Future<AuthEntity> getCurrentUser() {
    // Return Empty AuthEntity
    return Future.value(const AuthEntity(
      userId: "1",
      fName: "",
      lName: "",
      image: null,
      username: "",
      password: "",
    ));
  }

  @override
  Future<String> loginStudent(String username, String password) async {
    try {
      final user = await _hiveService.login(username, password);
      return Future.value("Login successful");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerStudent(AuthEntity student) async {
    try {
      // Convert AuthEntity to AuthHiveModel
      final authHiveModel = AuthHiveModel.fromEntity(student);

      await _hiveService.register(authHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
