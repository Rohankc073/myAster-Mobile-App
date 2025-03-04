import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myAster/features/auth/domain/use_case/signup_use_case.dart';
import 'package:myAster/features/auth/domain/use_case/upload_image_usecase.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final RegisterUseCase _registerUseCase;
  final UploadImageUsecase _uploadImageUsecase;

  SignupBloc({
    required RegisterUseCase registerUseCase,
    required UploadImageUsecase uploadImageUsecase,
  })  : _registerUseCase = registerUseCase,
        _uploadImageUsecase = uploadImageUsecase,
        super(SignupState.initial()) {
    on<LoadImage>(_onLoadImage);
    on<RegisterUser>(_onRegisterEvent);
  }

  // ✅ Handle User Registration Event
  void _onRegisterEvent(
    RegisterUser event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));

    final result = await _registerUseCase.call(RegisterUserParams(
      name: event.name,
      email: event.email,
      phone: event.phone,
      password: event.password,
      image: state.imageName, // ✅ Use uploaded image name from state
    ));

    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false, isSuccess: false, errorMessage: failure.message)),
      (_) => emit(state.copyWith(isLoading: false, isSuccess: true)),
    );
  }

  // ✅ Handle Image Upload Event
  void _onLoadImage(
    LoadImage event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _uploadImageUsecase.call(
      UploadImageParams(file: event.file),
    );

    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false, isSuccess: false, errorMessage: failure.message)),
      (imageName) => emit(state.copyWith(
          isLoading: false, isSuccess: false, imageName: imageName)),
    );
  }
}
