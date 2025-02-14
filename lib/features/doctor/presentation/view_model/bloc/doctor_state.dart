part of 'doctor_bloc.dart';

class DoctorState extends Equatable {
  final bool isLoading;
  final List<DoctorEntity> name;
  final List<DoctorEntity> specialization;
  final String error;

  const DoctorState({
    required this.isLoading,
    required this.name,
    required this.specialization,
    required this.error,
  });

  factory DoctorState.initial() {
    return const DoctorState(
      isLoading: false,
      name: [],
      specialization: [],
      error: '',
    );
  }

  DoctorState copyWith({
    bool? isLoading,
    List<DoctorEntity>? name,
    List<DoctorEntity>? specilization,
    String? error,
  }) {
    return DoctorState(
      isLoading: isLoading ?? this.isLoading,
      name: name ?? this.name,
      specialization: specialization ?? specialization,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, specialization, error, name];
}
