import 'dart:io';

import 'package:myAster/core/network/hive_service.dart';
import 'package:myAster/features/auth/data/datasource/auth_data_source.dart';
import 'package:myAster/features/auth/data/model/auth_hive_model.dart';
import 'package:myAster/features/auth/domain/entity/auth_entity.dart';
import 'package:myAster/features/auth/domain/use_case/login_use_case.dart';

class AuthLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDataSource(this._hiveService);

  // @override
  // Future<AuthEntity> getCurrentUser() async {
  //   try {
  //     final AuthHiveModel? user = await _hiveService.getCurrentUser();
  //     if (user != null) {
  //       return AuthEntity(
  //         userId: user.userId ?? '',  // Ensure userId is not null
  //         name: user.name,
  //         phone: user.phone,
  //         email: user.email,
  //         password: user.password,
  //         image: user.image,
  //       );
  //     }
  //     throw Exception("No user found in local storage.");
  //   } catch (e) {
  //     return Future.error("Failed to get current user: $e");
  //   }
  // }

  @override
  Future<AuthResponse> loginUser(String username, String password) async {
    try {
      final AuthHiveModel? user = await _hiveService.login(username, password);

      if (user != null) {
        if (user.userId == null || user.userId!.isEmpty) {
          throw Exception("Invalid user data: Missing userId.");
        }

        return Future.value(AuthResponse(
          token: 'local_token_${user.userId}', // Dummy token
          userId: user.userId!, // Use `!` to force non-null value
          name: user.name,
          email: user.email,
          role: "User", // Assign a default role
        ));
      } else {
        throw Exception("Invalid username or password.");
      }
    } catch (e) {
      return Future.error('Login failed: $e');
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      // Convert `AuthEntity` to `AuthHiveModel`
      final authHiveModel = AuthHiveModel.fromEntity(user);

      await _hiveService.register(authHiveModel);
      print("User Registered Successfully: ${authHiveModel.name}");
      return Future.value();
    } catch (e) {
      return Future.error("Registration failed: $e");
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }

  @override
  Future<String> receiveOtp(String email) {
    // TODO: implement receiveOtp
    throw UnimplementedError();
  }

  @override
  Future<void> setNewPassword(String email, String newPassword, String otp) {
    // TODO: implement setNewPassword
    throw UnimplementedError();
  }
}
