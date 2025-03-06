// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';

// import '../../../../app/usecase/usecase.dart';
// import '../../../../core/error/failure.dart';
// import '../../../workshop_user/domain/entity/user_entity.dart';
// import '../../../workshop_user/domain/repository/user_repository.dart';

// class GetUserByIdParams extends Equatable {
//   final String id;

//   const GetUserByIdParams({required this.id});

//   @override
//   List<Object?> get props => [id];
// }

// class GetUserByIdUseCase
//     implements UsecaseWithParams<UserEntity, GetUserByIdParams> {
//   final IUserRepository userRepository;

//   GetUserByIdUseCase({required this.userRepository});

//   @override
//   Future<Either<Failure, UserEntity>> call(GetUserByIdParams params) async {
//     return userRepository.getUserById(params.id);
//   }
// }
