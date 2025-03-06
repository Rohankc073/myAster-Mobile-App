import 'package:dartz/dartz.dart';
import 'package:myAster/app/useccase/usecase.dart';
import 'package:myAster/features/doctor/domain/entity/doctor_entity.dart';
import 'package:myAster/features/doctor/domain/repository/doctor_repository.dart';

import '../../../../core/error/failure.dart';

class GetAllDoctorsUseCase implements UsecaseWithoutParams<List<DoctorEntity>> {
  final IDoctorRepository doctorRepository;

  GetAllDoctorsUseCase({required this.doctorRepository});

  @override
  Future<Either<Failure, List<DoctorEntity>>> call() {
    return doctorRepository.getAllDoctors();
  }
}
