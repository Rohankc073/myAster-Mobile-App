import 'package:myasteer/features/doctor/domain/entity/doctor_entity.dart';

abstract interface class IDoctorDataSource {
  Future<void> addDoctor(DoctorEntity doctor);
  Future<List<DoctorEntity>> getAllDoctor();
  Future<void> deleteDoctor(String id);
}
