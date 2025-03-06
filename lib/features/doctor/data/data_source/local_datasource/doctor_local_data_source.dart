import 'package:myAster/features/doctor/data/data_source/doctor_data_source.dart';
import 'package:myAster/features/doctor/data/model/doctor_hive_model.dart';
import 'package:myAster/features/doctor/domain/entity/doctor_entity.dart';

import '../../../../../core/network/hive_service.dart';

class DoctorLocalDataSource implements IDoctorDataSource {
  final HiveService _hiveService;

  DoctorLocalDataSource(this._hiveService);

  @override
  Future<void> createDoctor(DoctorEntity doctorEntity) async {
    try {
      final doctorHiveModel = DoctorHiveModel.fromEntity(doctorEntity);
      await _hiveService.addDoctor(doctorHiveModel);
    } catch (e) {
      throw Exception('Error creating doctor: $e');
    }
  }

  // @override
  // Future<void> deleteDoctor(String id, String? token) async {
  //   try {
  //     await _hiveService.deleteDoctor(id);
  //   } catch (e) {
  //     throw Exception('Error deleting doctor: $e');
  //   }
  // }

  @override
  Future<List<DoctorEntity>> getAllDoctors() async {
    try {
      final doctors = await _hiveService.getAllDoctor();
      return doctors.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception('Error fetching all doctors: $e');
    }
  }

  // @override
  // Future<DoctorEntity> getDoctorById(String id) async {
  //   try {
  //     final doctorHiveModel = await _hiveService.getDoctorById(id);
  //     if (doctorHiveModel != null) {
  //       return doctorHiveModel.toEntity();
  //     } else {
  //       throw Exception('Doctor not found');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching doctor by ID: $e');
  //   }
  // }

  // @override
  // Future<void> updateDoctor(DoctorEntity doctorEntity) async {
  //   try {
  //     final doctorHiveModel = DoctorHiveModel.fromEntity(doctorEntity);
  //     await _hiveService.updateDoctor(doctorHiveModel);
  //   } catch (e) {
  //     throw Exception('Error updating doctor: $e');
  //   }
  // }
}
