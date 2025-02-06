import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:myasteer/app/shared_prefs/token_shared_prefs.dart';
import 'package:myasteer/core/network/api_service.dart';
import 'package:myasteer/core/network/hive_service.dart';
import 'package:myasteer/features/auth/data/datasource/local_data_source/local_data_source.dart';
import 'package:myasteer/features/auth/data/datasource/remote_data_source/remote_data_source.dart';
import 'package:myasteer/features/auth/data/repository/auth_local_repository.dart';
import 'package:myasteer/features/auth/data/repository/auth_remote_repository.dart';
import 'package:myasteer/features/auth/domain/use_case/login_use_case.dart';
import 'package:myasteer/features/auth/domain/use_case/signup_use_case.dart';
import 'package:myasteer/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:myasteer/features/auth/presentation/view_model/login/bloc/login_bloc.dart';
import 'package:myasteer/features/auth/presentation/view_model/signup/bloc/signup_bloc.dart';
import 'package:myasteer/features/splash/presentation/view_model/cubit/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSignupDependencies();
  await _initLoginDependencies();
  await _initSplashDependencies();
}

_initApiService() {
  //remote data souce
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initSignupDependencies() async {
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  //Upload image use case
  // getIt.registerLazySingleton<UploadImageUsecase>(
  //   () => UploadImageUsecase(
  //     getIt<AuthRemoteRepository>(),
  //   ),
  // );

  getIt.registerFactory<SignupBloc>(
    () => SignupBloc(
      registerUseCase: getIt(),
      uploadImageUsecase: getIt(),
    ),
  );

  //Remote data source
  getIt.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(getIt<Dio>()));

  //Repo Remotre
  getIt.registerLazySingleton<AuthRemoteRepository>(
      () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()));

  // getIt.registerFactory<SignupBloc>(
  //   () => SignupBloc(
  //     loginBloc: getIt<LoginBloc>(),
  //     registerUseCase: getIt(),
  //   ),
  // );

  //Remote data sourc
}

_initLoginDependencies() async {
  // =========================== Token Shared Preferences ===========================
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  // =========================== Usecases ===========================
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      authRepository: getIt<AuthRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      loginUseCase: getIt<LoginUseCase>(),
      signupBloc: getIt<SignupBloc>(),
    ),
  );
}

_initSplashDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<SignupBloc>()),
  );
}
