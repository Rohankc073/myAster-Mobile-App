import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myAster/app/di/di.dart';
import 'package:myAster/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:myAster/features/home/presentation/view/bottom_view/profile_view.dart';
import 'package:myAster/features/home/presentation/view/bottom_view/setting_view.dart';
import 'package:myAster/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:myAster/features/product/presentation/view/product_view.dart';
import 'package:myAster/features/product/presentation/view_model/product_bloc.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> pages;

  const HomeState({
    required this.selectedIndex,
    required this.pages,
  });

  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      pages: [
        BlocProvider(
            create: (context) => getIt<HomeCubit>(), child: const HomeScreen()),
        BlocProvider(
            create: (context) => getIt<ProductBloc>(),
            child:
                const ProductView()), // ✅ Fixed: Wrapped ProductView in BlocProvider
        BlocProvider(
            create: (context) => getIt<HomeCubit>(),
            child: const ProfileScreen()),
        BlocProvider(
            create: (context) => getIt<HomeCubit>(),
            child: const SettingsScreen()), // ✅ Fixed: Added Settings Page
      ],
    );
  }

  HomeState copyWith({
    int? index,
  }) {
    return HomeState(
      selectedIndex: index ?? selectedIndex,
      pages: pages,
    );
  }

  @override
  List<Object> get props => [selectedIndex, pages];
}
