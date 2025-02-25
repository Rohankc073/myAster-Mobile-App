// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:myasteer/app/useccase/usecase.dart';
// import 'package:myasteer/features/auth/domain/entity/auth_entity.dart';
// import 'package:myasteer/features/auth/domain/repository/auth_repository.dart';

// import '../../../../core/error/failure.dart';

// class GetUserByIdParams extends Equatable {
//   final String userId;

//   const GetUserByIdParams({required this.userId});

//   const GetUserByIdParams.empty() : userId = "_empty.string";

//   @override
//   List<Object?> get props => [userId];
// }

// class GetUserByIdUsecase implements UsecaseWithParams<void, GetUserByIdParams> {
//   final IAuthRepository userRepository;

//   const GetUserByIdUsecase({required this.userRepository});

//   @override
//   Future<Either<Failure, AuthEntity>> call(GetUserByIdParams params) async {
//     return await userRepository.getCurrentUser();
//   }
// }
