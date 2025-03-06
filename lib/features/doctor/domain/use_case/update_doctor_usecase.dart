// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';

// import '../../../../app/shared_prefs/token_shared_prefs.dart';
// import '../../../../app/usecase/usecase.dart';
// import '../../../../core/error/failure.dart';
// import '../../../workshop_user/domain/entity/user_entity.dart';
// import '../../../workshop_user/domain/repository/user_repository.dart';

// class UpdateUserParams extends Equatable {
//   final String? id;
//   final String name;
//   final String? description;
//   final String? photo;

//   const UpdateUserParams({
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

// class UpdateUserUseCase
//     implements UsecaseWithParams<void, UpdateUserParams> {
//   final IUserRepository userRepository;
//   final TokenSharedPrefs tokenSharedPrefs;

//   const UpdateUserUseCase(
//       {required this.userRepository, required this.tokenSharedPrefs});

//   @override
//   Future<Either<Failure, void>> call(UpdateUserParams params) async {
//     final userEntity = UserEntity(
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
//       return await userRepository.updateUser(userEntity, r);
//     });

//     // return await userRepository.updateUser(userEntity);
//   }
// }
