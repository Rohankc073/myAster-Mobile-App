// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';

// import '../../../../app/shared_prefs/token_shared_prefs.dart';
// import '../../../../app/usecase/usecase.dart';
// import '../../../../core/error/failure.dart';
// import '../../../workshop_doctor/domain/entity/doctor_entity.dart';
// import '../../../workshop_doctor/domain/repository/doctor_repository.dart';

// class UpdateDoctorParams extends Equatable {
//   final String? id;
//   final String name;
//   final String? description;
//   final String? photo;

//   const UpdateDoctorParams({
//     this.id,
//     required this.name,
//     this.description,
//     this.photo,
//   });

//   @override
//   List<Object?> get props => [
//         name,
//         description,
//         photo,
//       ];

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'description': description,
//       'photo': photo,
//     };
//   }
// }

// class UpdateDoctorUseCase
//     implements UsecaseWithParams<void, UpdateDoctorParams> {
//   final IDoctorRepository doctorRepository;
//   final TokenSharedPrefs tokenSharedPrefs;

//   const UpdateDoctorUseCase(
//       {required this.doctorRepository, required this.tokenSharedPrefs});

//   @override
//   Future<Either<Failure, void>> call(UpdateDoctorParams params) async {
//     final doctorEntity = DoctorEntity(
//       id: null,
//       name: params.name,
//       description: params.description,
//       photo: params.photo,
//     );

//     // Get token from Shared Preferences and send it to server
//     final token = await tokenSharedPrefs.getToken();
//     return token.fold((l) {
//       return Left(l);
//     }, (r) async {
//       return await doctorRepository.updateDoctor(doctorEntity, r);
//     });

//     // return await doctorRepository.updateDoctor(doctorEntity);
//   }
// }
