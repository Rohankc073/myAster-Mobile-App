import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myAster/features/doctor/presentation/view_model/doctor_state.dart';

import '../../domain/use_case/get_all_doctor_usecase.dart';

part 'doctor_event.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  // final CreateDoctorUseCase _createDoctorUseCase;
  final GetAllDoctorsUseCase _getAllDoctorsUseCase;
  // final DeleteDoctorUseCase _deleteDoctorUseCase;
  // final UpdateDoctorUseCase _updateDoctorUseCase;

  DoctorBloc({
    // required CreateDoctorUseCase createDoctorUseCase,
    required GetAllDoctorsUseCase getAllDoctorsUseCase,
    // required DeleteDoctorUseCase deleteDoctorUseCase,
    // required UpdateDoctorUseCase updateDoctorUseCase,
  })  :
        // _createDoctorUseCase = createDoctorUseCase,
        _getAllDoctorsUseCase = getAllDoctorsUseCase,
        // _deleteDoctorUseCase = deleteDoctorUseCase,
        // _updateDoctorUseCase = updateDoctorUseCase,
        super(DoctorState.initial()) {
    on<LoadDoctors>(_onLoadDoctors);
    // on<AddDoctor>(_onAddDoctor);
    // on<DeleteDoctor>(_onDeleteDoctor);
    // on<UpdateDoctor>(_onUpdateDoctor);

    // Need to comment before running the Bloc Test
    // Trigger initial loading
    add(LoadDoctors());
  }

  Future<void> _onLoadDoctors(
      LoadDoctors event, Emitter<DoctorState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllDoctorsUseCase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (categories) => emit(state.copyWith(
        isLoading: false,
        error: null,
        categories: categories,
      )),
    );
  }

  // Future<void> _onAddDoctor(AddDoctor event, Emitter<DoctorState> emit) async {
  //   emit(state.copyWith(isLoading: true));
  //   final result = await _createDoctorUseCase.call(
  //     CreateDoctorParams(
  //         name: event.name,
  //         description: event.description,
  //         photo: state.imageName),
  //   );
  //   result.fold(
  //     (failure) =>
  //         emit(state.copyWith(isLoading: false, error: failure.message)),
  //     (_) => add(LoadDoctors()),
  //   );
  // }

  // Future<void> _onDeleteDoctor(
  //     DeleteDoctor event, Emitter<DoctorState> emit) async {
  //   emit(state.copyWith(isLoading: true));
  //   final result = await _deleteDoctorUseCase.call(
  //     DeleteDoctorParams(id: event.id),
  //   );
  //   result.fold(
  //     (failure) =>
  //         emit(state.copyWith(isLoading: false, error: failure.message)),
  //     (_) => add(LoadDoctors()),
  //   );
  // }

  // Future<void> _onUpdateDoctor(
  //     UpdateDoctor event, Emitter<DoctorState> emit) async {
  //   emit(state.copyWith(isLoading: true));
  //   final result = await _updateDoctorUseCase.call(
  //     UpdateDoctorParams(
  //         name: event.name, description: event.description, photo: event.photo),
  //   );
  //   result.fold(
  //     (failure) =>
  //         emit(state.copyWith(isLoading: false, error: failure.message)),
  //     (_) => add(LoadDoctors()), // Reload categories after editing
  //   );
  // }
}
