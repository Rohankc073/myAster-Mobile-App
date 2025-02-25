import 'dart:io';

import 'package:dio/dio.dart';
import 'package:myasteer/app/constants/api_endpoints.dart';
import 'package:myasteer/features/auth/data/datasource/auth_data_source.dart';
import 'package:myasteer/features/auth/data/model/auth_api_model.dart';
import 'package:myasteer/features/auth/domain/entity/auth_entity.dart';
import 'package:myasteer/features/auth/domain/use_case/login_use_case.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<AuthResponse> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        print("Login API Response: ${response.data}"); // Debugging output

        final String token = response.data['token'];
        final Map<String, dynamic> userData =
            Map<String, dynamic>.from(response.data['user']);

        final String userId = userData['_id']; // Extract correct user ID
        final String name = userData['name'];
        final String email = userData['email'];
        final String role = userData['role'];

        return AuthResponse(
          token: token,
          userId: userId,
          name: name,
          email: email,
          role: role,
        );
      } else {
        throw Exception('Login failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Network error during login: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      var studentApiModel = AuthApiModel.fromEntity(user);
      var response = await _dio.post(
        ApiEndpoints.register,
        data: studentApiModel.toJson(),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to register: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Network error during registration: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "profilePicture":
            await MultipartFile.fromFile(file.path, filename: fileName)
      });

      Response response =
          await _dio.post(ApiEndpoints.uploadImage, data: formData);

      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Network error during profile upload: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
