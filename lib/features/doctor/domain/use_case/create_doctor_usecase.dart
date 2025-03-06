// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:myasteer/app/useccase/usecase.dart';
// import 'package:myasteer/core/error/failure.dart';
// import 'package:myasteer/features/user/domain/repository/user_repository.dart';

// class CreateUserParams extends Equatable {
//   final String name;
//   final String? description;
//   final String? photo;

//   const CreateUserParams({
//     required this.name,
//     this.description,
//     this.photo,
//   });

//   // Initialize Empty Constructor
//   const CreateUserParams.empty()
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

// class CreateUserUseCase
//     implements UsecaseWithParams<void, CreateUserParams> {
//   final IUserRepository userRepository;

//   CreateUserUseCase({required this.userRepository});

//   @override
//   Future<Either<Failure, void>> call(CreateUserParams params) async {
//     return await userRepository.createUser(
//       UserEntity(
//         name: params.name,
//         description: params.description,
//         photo: params.photo,
//       ),
//     );
//   }
// }
