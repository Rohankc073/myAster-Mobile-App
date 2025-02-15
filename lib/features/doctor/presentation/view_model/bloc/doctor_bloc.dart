import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myasteer/features/doctor/domain/entity/doctor_entity.dart';
import 'package:myasteer/features/doctor/domain/use_case/create_doctor_usecase.dart';
import 'package:myasteer/features/doctor/domain/use_case/get_all_doctor_usecase.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final CreateDoctorUsecase _createDoctorUsecase;
  final GetAllDoctorUsecase _getAllDoctorUsecase;
  DoctorBloc({
    required CreateDoctorUsecase createDoctorUseCase,
    required GetAllDoctorUsecase getAllDoctorUseCase,
  })  : _createDoctorUsecase = createDoctorUseCase,
        _getAllDoctorUsecase = getAllDoctorUseCase,
        super(DoctorState.initial()) {
    on<CreateDoctor>(_onCreateDoctor);
    on<DoctorLoad>(_onLoadDoctors);
    add(DoctorLoad());
  }

  Future<void> _onLoadDoctors(
      DoctorLoad event, Emitter<DoctorState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllDoctorUsecase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (name) => emit(state.copyWith(isLoading: false, name: name)),
    );
  }

  Future<void> _onCreateDoctor(
    CreateDoctor event,
    Emitter<DoctorState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createDoctorUsecase(CreateDoctorParams(
        name: event.name,
        specialization: event.specialization,
        availableDays: event.availableDays,
        availableTimes: event.availableTimes,
        email: event.email,
        contact: event.contact));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false));
        add(DoctorLoad());
      },
    );
  }
}
