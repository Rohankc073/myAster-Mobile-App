import 'package:equatable/equatable.dart';
import 'package:myasteer/features/doctor/domain/entity/doctor_entity.dart';

class DoctorState extends Equatable {
  final List<DoctorEntity> doctors;
  final bool isLoading;
  final String? error;
  final bool isImageLoading;
  final bool isImageSuccess;
  final String? imageName;

  const DoctorState({
    required this.doctors,
    required this.isLoading,
    this.error,
    required this.isImageLoading,
    required this.isImageSuccess,
    this.imageName,
  });

  factory DoctorState.initial() {
    return const DoctorState(
      doctors: [],
      isLoading: false,
      isImageLoading: false,
      isImageSuccess: false,
      imageName: null,
    );
  }

  DoctorState copyWith({
    List<DoctorEntity>? categories,
    bool? isLoading,
    String? error,
    bool? isImageLoading,
    bool? isImageSuccess,
    String? imageName,
  }) {
    return DoctorState(
      doctors: categories ?? doctors,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isImageLoading: isImageLoading ?? this.isImageLoading,
      isImageSuccess: isImageSuccess ?? this.isImageSuccess,
      imageName: imageName ?? this.imageName,
    );
  }

  @override
  List<Object?> get props => [
        doctors,
        isLoading,
        error,
        isImageLoading,
        isImageSuccess,
        imageName,
      ];
}
