// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:nirlipta_yoga_mobile/app/shared_prefs/token_shared_prefs.dart';

// import '../../../../app/usecase/usecase.dart';
// import '../../../../core/error/failure.dart';
// import '../../../workshop_doctor/domain/repository/doctor_repository.dart';

// class DeleteDoctorParams extends Equatable {
//   final String id;

//   const DeleteDoctorParams({required this.id});

//   // Initialize Empty Constructor
//   const DeleteDoctorParams.empty() : id = '_empty.id';

//   @override
//   List<Object?> get props => [id];
// }

// class DeleteDoctorUseCase
//     implements UsecaseWithParams<void, DeleteDoctorParams> {
//   final IDoctorRepository doctorRepository;
//   final TokenSharedPrefs tokenSharedPrefs;

//   DeleteDoctorUseCase(
//       {required this.doctorRepository, required this.tokenSharedPrefs});

//   @override
//   Future<Either<Failure, void>> call(DeleteDoctorParams params) async {
//     // Get token from Shared Preferences and send it to server
//     final token = await tokenSharedPrefs.getToken();
//     return token.fold((l) {
//       return Left(l);
//     }, (r) async {
//       return await doctorRepository.deleteDoctor(params.id, r);
//     });
//   }
// }
