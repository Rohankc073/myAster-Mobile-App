// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:nirlipta_yoga_mobile/app/shared_prefs/token_shared_prefs.dart';

// import '../../../../app/usecase/usecase.dart';
// import '../../../../core/error/failure.dart';
// import '../../../workshop_user/domain/repository/user_repository.dart';

// class DeleteUserParams extends Equatable {
//   final String id;

//   const DeleteUserParams({required this.id});

//   // Initialize Empty Constructor
//   const DeleteUserParams.empty() : id = '_empty.id';

//   @override
//   List<Object?> get props => [id];
// }

// class DeleteUserUseCase
//     implements UsecaseWithParams<void, DeleteUserParams> {
//   final IUserRepository userRepository;
//   final TokenSharedPrefs tokenSharedPrefs;

//   DeleteUserUseCase(
//       {required this.userRepository, required this.tokenSharedPrefs});

//   @override
//   Future<Either<Failure, void>> call(DeleteUserParams params) async {
//     // Get token from Shared Preferences and send it to server
//     final token = await tokenSharedPrefs.getToken();
//     return token.fold((l) {
//       return Left(l);
//     }, (r) async {
//       return await userRepository.deleteUser(params.id, r);
//     });
//   }
// }
