import 'package:dio/dio.dart';
import 'package:myAster/features/doctor/data/model/doctor_api_model.dart';
import 'package:myAster/features/doctor/domain/entity/doctor_entity.dart';

import '../../../../../app/constants/api_endpoints.dart';

class DoctorRemoteDataSource {
  final Dio _dio;

  DoctorRemoteDataSource(this._dio);

  // Future<void> createDoctor(DoctorEntity doctor) async {
  //   try {
  //     // Convert entity to model
  //     var doctorApiModel = DoctorApiModel.fromEntity(doctor);
  //     var response = await _dio.post(
  //       ApiEndpoints.createDoctor,
  //       data: doctorApiModel.toJson(),
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

  Future<List<DoctorEntity>> getAllDoctors() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllDoctor);
      if (response.statusCode == 200) {
        var data = response.data as List<dynamic>;
        return data
            .map((doctor) => DoctorApiModel.fromJson(doctor).toEntity())
            .toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Future<DoctorEntity> getDoctorById(String id) async {
  //   try {
  //     var response = await _dio.get('${ApiEndpoints.getDoctorById}/$id');
  //     if (response.statusCode == 200) {
  //       return DoctorApiModel.fromJson(response.data).toEntity();
  //     } else {
  //       throw Exception(response.statusMessage);
  //     }
  //   } on DioException catch (e) {
  //     throw Exception(e.message);
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  // Future<void> updateDoctor(DoctorEntity doctorEntity) async {
  //   try {
  //     var doctorApiModel = DoctorApiModel.fromEntity(doctorEntity);
  //     var response = await _dio.put(
  //       '${ApiEndpoints.updateDoctor}/${doctorEntity.id}',
  //       data: doctorApiModel.toJson(),
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

  // Future<void> deleteDoctor(String id, String? token) async {
  //   try {
  //     var response = await _dio.delete('${ApiEndpoints.deleteDoctor}/$id');
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
