import 'package:dio/dio.dart';
import 'package:myasteer/app/constants/api_endpoints.dart';
import 'package:myasteer/features/doctor/data/data_source/doctor_datasource.dart';
import 'package:myasteer/features/doctor/data/model/doctor_api_model.dart';
import 'package:myasteer/features/doctor/domain/entity/doctor_entity.dart';

class DoctorRemoteDatasource implements IDoctorDataSource {
  final Dio _dio;

  DoctorRemoteDatasource(this._dio);

  @override
  Future<void> addDoctor(DoctorEntity doctor) async {
    try {
      // Convert Course Entity to Course API Model
      var courseApiModel = DoctorApiModel.fromEntity(doctor);
      var response = await _dio.post(
        ApiEndpoints.addDoctor,
        data: courseApiModel.toJson(),
      );

      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  // @override
  // Future<List<DoctorEntity>> getAllDoctor() async {
  //   try {
  //     var response = await _dio.get(ApiEndpoints.getAllDoctor);
  //     if (response.statusCode == 200) {
  //       // Convert API response to DTO
  //       var courseDTO = GetAllCourseDTO.fromJson(response.data);
  //       // Convert DTO to Entity
  //       return CourseApiModel.toEntityList(courseDTO.data);
  //     } else {
  //       throw Exception(response.statusMessage);
  //     }
  //   } on DioException catch (e) {
  //     throw Exception(e);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  @override
  Future<void> deleteDoctor(String id) {
    // TODO: implement deleteDoctor
    throw UnimplementedError();
  }

  @override
  Future<List<DoctorEntity>> getAllDoctor() {
    // TODO: implement getAllDoctor
    throw UnimplementedError();
  }
}
