// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';

// import '../../../../app/usecase/usecase.dart';
// import '../../../../core/error/failure.dart';
// import '../../../workshop_doctor/domain/entity/doctor_entity.dart';
// import '../../../workshop_doctor/domain/repository/doctor_repository.dart';

// class GetDoctorByIdParams extends Equatable {
//   final String id;

//   const GetDoctorByIdParams({required this.id});

//   @override
//   List<Object?> get props => [id];
// }

// class GetDoctorByIdUseCase
//     implements UsecaseWithParams<DoctorEntity, GetDoctorByIdParams> {
//   final IDoctorRepository doctorRepository;

//   GetDoctorByIdUseCase({required this.doctorRepository});

//   @override
//   Future<Either<Failure, DoctorEntity>> call(GetDoctorByIdParams params) async {
//     return doctorRepository.getDoctorById(params.id);
//   }
// }
