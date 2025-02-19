import 'package:dartz/dartz.dart';
import 'package:myasteer/app/useccase/usecase.dart';
import 'package:myasteer/features/doctor/domain/entity/doctor_entity.dart';
import 'package:myasteer/features/doctor/domain/repository/doctor_repository.dart';

import '../../../../core/error/failure.dart';

class GetAllDoctorsUseCase implements UsecaseWithoutParams<List<DoctorEntity>> {
  final IDoctorRepository doctorRepository;

  GetAllDoctorsUseCase({required this.doctorRepository});

  @override
  Future<Either<Failure, List<DoctorEntity>>> call() {
    return doctorRepository.getAllDoctors();
  }
}
