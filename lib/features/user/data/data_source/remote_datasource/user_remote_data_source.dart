import 'package:dio/dio.dart';
import 'package:myAster/features/user/data/model/user_api_model.dart';
import 'package:myAster/features/user/domain/entity/user_entity.dart';

import '../../../../../app/constants/api_endpoints.dart';

class UserRemoteDataSource {
  final Dio _dio;

  UserRemoteDataSource(this._dio);

  // Future<void> createUser(UserEntity user) async {
  //   try {
  //     // Convert entity to model
  //     var userApiModel = UserApiModel.fromEntity(user);
  //     var response = await _dio.post(
  //       ApiEndpoints.createUser,
  //       data: userApiModel.toJson(),
  //     );
  //     if (response.statusCode == 201) {
  //       return;
  //     } else {
  //       throw Exception(response.statusMessage);
  //     }
  //   } on DioException catch (e) {
  //     throw Exception(e.message);
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  // Future<List<UserEntity>> getAllUsers() async {
  //   try {
  //     var response = await _dio.get(ApiEndpoints.getAllUser);
  //     if (response.statusCode == 200) {
  //       var data = response.data as List<dynamic>;
  //       return data
  //           .map((user) => UserApiModel.fromJson(user).toEntity())
  //           .toList();
  //     } else {
  //       throw Exception(response.statusMessage);
  //     }
  //   } on DioException catch (e) {
  //     throw Exception(e.message);
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  Future<UserEntity> getUserById(String id) async {
    try {
      var response = await _dio.get('${ApiEndpoints.getUserById}/$id');
      if (response.statusCode == 200) {
        return UserApiModel.fromJson(response.data).toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Future<void> updateUser(UserEntity userEntity) async {
  //   try {
  //     var userApiModel = UserApiModel.fromEntity(userEntity);
  //     var response = await _dio.put(
  //       '${ApiEndpoints.updateUser}/${userEntity.id}',
  //       data: userApiModel.toJson(),
  //     );
  //     if (response.statusCode == 200) {
  //       return;
  //     } else {
  //       throw Exception(response.statusMessage);
  //     }
  //   } on DioException catch (e) {
  //     throw Exception(e.message);
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  // Future<void> deleteUser(String id, String? token) async {
  //   try {
  //     var response = await _dio.delete('${ApiEndpoints.deleteUser}/$id');
  //     if (response.statusCode == 200) {
  //       return;
  //     } else {
  //       throw Exception(response.statusMessage);
  //     }
  //   } on DioException catch (e) {
  //     throw Exception(e.message);
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }
}
