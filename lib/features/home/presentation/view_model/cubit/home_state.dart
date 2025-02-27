part of 'home_cubit.dart';

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
            create: (context) => getIt<HomeCubit>(), child: const HomeScreen()),
        BlocProvider(
            create: (context) => getIt<HomeCubit>(), child: const HomeScreen())
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
