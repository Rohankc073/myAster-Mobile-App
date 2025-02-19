// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:myasteer/app/useccase/usecase.dart';
// import 'package:myasteer/core/error/failure.dart';
// import 'package:myasteer/features/doctor/domain/repository/doctor_repository.dart';

// class CreateDoctorParams extends Equatable {
//   final String name;
//   final String? description;
//   final String? photo;

//   const CreateDoctorParams({
//     required this.name,
//     this.description,
//     this.photo,
//   });

//   // Initialize Empty Constructor
//   const CreateDoctorParams.empty()
//       : name = '_empty.name',
//         description = '_empty.description',
//         photo = '_empty.photo';

//   @override
//   List<Object?> get props => [
//         name,
//         description,
//         photo,
//       ];
// }

// class CreateDoctorUseCase
//     implements UsecaseWithParams<void, CreateDoctorParams> {
//   final IDoctorRepository doctorRepository;

//   CreateDoctorUseCase({required this.doctorRepository});

//   @override
//   Future<Either<Failure, void>> call(CreateDoctorParams params) async {
//     return await doctorRepository.createDoctor(
//       DoctorEntity(
//         name: params.name,
//         description: params.description,
//         photo: params.photo,
//       ),
//     );
//   }
// }
