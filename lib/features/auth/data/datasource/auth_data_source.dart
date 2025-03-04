import 'dart:io';

import 'package:myAster/features/auth/domain/entity/auth_entity.dart';
import 'package:myAster/features/auth/domain/use_case/login_use_case.dart';

abstract interface class IAuthDataSource {
  Future<AuthResponse> loginUser(String username, String password);
  Future<void> registerUser(AuthEntity user);

  // Future<AuthEntity> getCurrentUser();

  Future<String> uploadProfilePicture(File file);
}
