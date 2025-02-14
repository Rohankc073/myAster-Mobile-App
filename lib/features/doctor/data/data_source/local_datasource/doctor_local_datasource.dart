import 'package:myasteer/core/error/failure.dart';
import 'package:myasteer/core/network/hive_service.dart';
import 'package:myasteer/features/doctor/data/data_source/doctor_datasource.dart';
import 'package:myasteer/features/doctor/data/model/doctor_hive_model.dart';
import 'package:myasteer/features/doctor/domain/entity/doctor_entity.dart';

class DoctorLocalDatasource implements IDoctorDataSource {
  final HiveService _hiveService;

  DoctorLocalDatasource({required HiveService hiveService})
      : _hiveService = hiveService;

  @override
  Future<void> addDoctor(DoctorEntity doctor) async {
    try {
      // Convert course entity to course model
      final doctorHiveModel = DoctorHiveModel.fromEntity(doctor);
      _hiveService.addDoctors(doctorHiveModel);
    } catch (e) {
      throw LocalDatabaseFailure(message: e.toString());
    }
  }

  @override
  Future<void> deleteDoctor(String id) async {
    try {
      _hiveService.deleteDoctor(id);
    } catch (e) {
      throw LocalDatabaseFailure(message: e.toString());
    }
  }

  @override
  Future<List<DoctorEntity>> getAllDoctor() async {
    try {
      final doctorHiveModelList = await _hiveService.getAllDoctor();
      return DoctorHiveModel.toEntityList(doctorHiveModelList);
    } catch (e) {
      throw LocalDatabaseFailure(message: e.toString());
    }
  }
}
