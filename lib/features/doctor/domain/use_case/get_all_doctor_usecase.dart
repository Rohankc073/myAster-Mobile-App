import 'package:dartz/dartz.dart';
import 'package:myasteer/app/useccase/usecase.dart';
import 'package:myasteer/core/error/failure.dart';
import 'package:myasteer/features/doctor/domain/entity/doctor_entity.dart';
import 'package:myasteer/features/doctor/domain/repository/doctor_repository.dart';

class GetAllDoctorUsecase implements UsecaseWithoutParams<List<DoctorEntity>> {
  final IDoctorRepository doctorRepository;

  GetAllDoctorUsecase({required this.doctorRepository});

  @override
  Future<Either<Failure, List<DoctorEntity>>> call() {
    return doctorRepository.getAllDoctors();
  }
}
