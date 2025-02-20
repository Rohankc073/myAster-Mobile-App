import 'package:equatable/equatable.dart';
import 'package:myasteer/features/user/domain/entity/user_entity.dart';

class UserState extends Equatable {
  final List<UserEntity> users;
  final bool isLoading;
  final String? error;
  final bool isImageLoading;
  final bool isImageSuccess;
  final String? imageName;

  const UserState({
    required this.users,
    required this.isLoading,
    this.error,
    required this.isImageLoading,
    required this.isImageSuccess,
    this.imageName,
  });

  factory UserState.initial() {
    return const UserState(
      users: [],
      isLoading: false,
      isImageLoading: false,
      isImageSuccess: false,
      imageName: null,
    );
  }

  UserState copyWith({
    List<UserEntity>? categories,
    bool? isLoading,
    String? error,
    bool? isImageLoading,
    bool? isImageSuccess,
    String? imageName,
  }) {
    return UserState(
      users: categories ?? users,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isImageLoading: isImageLoading ?? this.isImageLoading,
      isImageSuccess: isImageSuccess ?? this.isImageSuccess,
      imageName: imageName ?? this.imageName,
    );
  }

  @override
  List<Object?> get props => [
        users,
        isLoading,
        error,
        isImageLoading,
        isImageSuccess,
        imageName,
      ];
}
