import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myasteer/features/auth/domain/use_case/signup_use_case.dart';
import 'package:myasteer/features/auth/domain/use_case/upload_image_usecase.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final RegisterUseCase _registerUseCase;
  final UploadImageUsecase _uploadImageUsecase;
  // final LoginBloc _loginBloc;

  SignupBloc({
    // required LoginBloc loginBloc,
    required RegisterUseCase registerUseCase,
    required UploadImageUsecase uploadImageUsecase,
  })  : _registerUseCase = registerUseCase,
        _uploadImageUsecase = uploadImageUsecase,
        // _loginBloc = loginBloc,
        super(SignupState.initial()) {
    // on<NavigateLoginScreenEvent>((event, emit) {
    //   Navigator.push(
    //       event.context,
    //       MaterialPageRoute(
    //           builder: (context) => MultiBlocProvider(
    //               providers: [BlocProvider.value(value: _loginBloc)],
    //               child: event.destination)));
    // });
    on<LoadImage>(_onLoadImage);
    on<RegisterUser>(_onRegisterEvent);
  }

  void _onRegisterEvent(
    RegisterUser event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerUseCase.call(RegisterUserParams(
        name: event.name,
        email: event.email,
        phone: event.phone,
        password: event.password));

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
      },
    );
  }

  void _onLoadImage(
    LoadImage event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _uploadImageUsecase.call(
      UploadImageParams(file: event.file),
    );

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true, imageName: r));
      },
    );
  }
}
