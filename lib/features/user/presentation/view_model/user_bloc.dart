import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myAster/features/user/domain/use_case/get_user_by_id_usecase.dart';
import 'package:myAster/features/user/presentation/view_model/user_state.dart';

part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  // final CreateUserUseCase _createUserUseCase;
  // final GetAllUsersUseCase _getAllUsersUseCase;
  // final DeleteUserUseCase _deleteUserUseCase;
  // final UpdateUserUseCase _updateUserUseCase;
  final GetUserByIdUseCase _getUserByIdUseCase;

  UserBloc({
    // required CreateUserUseCase createUserUseCase,
    // required GetAllUsersUseCase getAllUsersUseCase,
    required GetUserByIdUseCase getUserByIdUseCase,
    // required DeleteUserUseCase deleteUserUseCase,
    // required UpdateUserUseCase updateUserUseCase,
  })  :
        // _createUserUseCase = createUserUseCase,
        _getUserByIdUseCase = getUserByIdUseCase,
        // _getAllUsersUseCase = getAllUsersUseCase,
        // _deleteUserUseCase = deleteUserUseCase,
        // _updateUserUseCase = updateUserUseCase,
        super(UserState.initial()) {
    // on<LoadUsers>(_onLoadUsers);
    // on<AddUser>(_onAddUser);
    // on<DeleteUser>(_onDeleteUser);
    // on<UpdateUser>(_onUpdateUser);

    // Need to comment before running the Bloc Test
    // Trigger initial loading
    add(LoadUsers());
  }

  // Future<void> _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
  //   emit(state.copyWith(isLoading: true));
  //   final result = await _getUserByIdUseCase.call(user);
  //   result.fold(
  //     (failure) =>
  //         emit(state.copyWith(isLoading: false, error: failure.message)),
  //     (categories) => emit(state.copyWith(
  //       isLoading: false,
  //       error: null,
  //     )),
  //   );
  // }

  // Future<void> _onAddUser(AddUser event, Emitter<UserState> emit) async {
  //   emit(state.copyWith(isLoading: true));
  //   final result = await _createUserUseCase.call(
  //     CreateUserParams(
  //         name: event.name,
  //         description: event.description,
  //         photo: state.imageName),
  //   );
  //   result.fold(
  //     (failure) =>
  //         emit(state.copyWith(isLoading: false, error: failure.message)),
  //     (_) => add(LoadUsers()),
  //   );
  // }

  // Future<void> _onDeleteUser(
  //     DeleteUser event, Emitter<UserState> emit) async {
  //   emit(state.copyWith(isLoading: true));
  //   final result = await _deleteUserUseCase.call(
  //     DeleteUserParams(id: event.id),
  //   );
  //   result.fold(
  //     (failure) =>
  //         emit(state.copyWith(isLoading: false, error: failure.message)),
  //     (_) => add(LoadUsers()),
  //   );
  // }

  // Future<void> _onUpdateUser(
  //     UpdateUser event, Emitter<UserState> emit) async {
  //   emit(state.copyWith(isLoading: true));
  //   final result = await _updateUserUseCase.call(
  //     UpdateUserParams(
  //         name: event.name, description: event.description, photo: event.photo),
  //   );
  //   result.fold(
  //     (failure) =>
  //         emit(state.copyWith(isLoading: false, error: failure.message)),
  //     (_) => add(LoadUsers()), // Reload categories after editing
  //   );
  // }
}
