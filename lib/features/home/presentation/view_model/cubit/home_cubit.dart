import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myAster/app/di/di.dart';
import 'package:myAster/features/auth/presentation/view/login_page.dart';
import 'package:myAster/features/auth/presentation/view_model/login/bloc/login_bloc.dart';
import 'package:myAster/features/home/presentation/view/bottom_view/dashboard_view.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());
  void onTabTapped(int index) {
    emit(state.copyWith(index: index));
  }

  void logout(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (context.mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                      value: getIt<LoginBloc>(),
                      child: LoginView(),
                    )));
      }
    });
  }
}
