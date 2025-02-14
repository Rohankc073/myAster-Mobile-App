import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myasteer/features/doctor/domain/entity/doctor_entity.dart';
import 'package:myasteer/features/doctor/domain/use_case/create_doctor_usecase.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final CreateDoctorUsecase _createDoctorUsecase;
  DoctorBloc({
    required CreateDoctorUsecase createDoctorUseCase,
  })  : _createDoctorUsecase = createDoctorUseCase,
        super(DoctorState.initial()) {
    on<CreateDoctor>(_onCreateDoctor);
    add(DoctorLoad());
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
