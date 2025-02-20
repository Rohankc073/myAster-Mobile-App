part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

final class LoadUsers extends UserEvent {}

final class LoadUser extends UserEvent {}

final class AddUser extends UserEvent {
  final String name;
  final String? description;
  final String? photo;

  const AddUser(
      {required this.name, required this.description, required this.photo});

  @override
  List<Object?> get props => [name, description, photo];
}

final class DeleteUser extends UserEvent {
  final String id;

  const DeleteUser({required this.id});

  @override
  List<Object?> get props => [id];
}

final class UpdateUser extends UserEvent {
  final String id;
  final String name;
  final String? description;
  final String? photo;

  const UpdateUser({
    required this.id,
    required this.name,
    this.description,
    this.photo,
  });

  @override
  List<Object?> get props => [id, name, description, photo];
}
