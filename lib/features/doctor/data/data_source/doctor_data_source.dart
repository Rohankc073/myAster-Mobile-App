import 'package:myAster/features/doctor/domain/entity/doctor_entity.dart';

abstract interface class IDoctorDataSource {
  Future<void> createDoctor(DoctorEntity doctorEntity);

  Future<List<DoctorEntity>> getAllDoctors();

  // Future<DoctorEntity> getDoctorById(String id);

  // Future<void> updateDoctor(DoctorEntity doctorEntity);

  // Future<void> deleteDoctor(String id, String? token);
}
