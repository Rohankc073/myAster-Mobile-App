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
import 'package:myasteer/features/doctor/data/data_source/local_datasource/doctor_local_data_source.dart';
import 'package:myasteer/features/doctor/data/data_source/remote_datasource/doctor_remote_data_source.dart';
import 'package:myasteer/features/doctor/data/repository/doctor_local_repository.dart';
import 'package:myasteer/features/doctor/data/repository/doctor_remote_repository.dart';
import 'package:myasteer/features/doctor/domain/use_case/get_all_doctor_usecase.dart';
import 'package:myasteer/features/doctor/presentation/view_model/doctor_bloc.dart';
import 'package:myasteer/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:myasteer/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:myasteer/features/splash/presentation/view_model/cubit/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();
  await _initSplashDependencies();
  await _initOnboardingDependencies();

  await _initLoginDependencies();
  await _initSignupDependencies();
  await _initHomeDependencies();
  await _initDoctorDependencies();
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

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initHomeDependencies() async {
  getIt.registerSingleton<HomeCubit>(HomeCubit());
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

  // getIt.registerFactory<SignupBloc>(
  //   () => SignupBloc(
  //     registerUseCase: getIt(),
  //     uploadImageUsecase: getIt(),
  //   ),
  // );

  //Remote data source
  getIt.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(getIt<Dio>()));

  //Repo Remotre
  getIt.registerLazySingleton<AuthRemoteRepository>(
      () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()));

  getIt.registerFactory<SignupBloc>(
    () => SignupBloc(
      registerUseCase: getIt(),
      uploadImageUsecase: getIt<UploadImageUsecase>(),
    ),
  );

  //Remote data sourc
}

_initDoctorDependencies() async {
  // Local Data Source
  getIt.registerFactory<DoctorLocalDataSource>(
      () => DoctorLocalDataSource(getIt<HiveService>()));

  // Remote Data Source
  getIt.registerFactory<DoctorRemoteDataSource>(
      () => DoctorRemoteDataSource(getIt<Dio>()));

  // Local Repository
  getIt.registerLazySingleton<DoctorLocalRepository>(() =>
      DoctorLocalRepository(
          doctorLocalDataSource: getIt<DoctorLocalDataSource>()));

  // Remote Repository
  getIt.registerLazySingleton<DoctorRemoteRepository>(() =>
      DoctorRemoteRepository(
          doctorRemoteDataSource: getIt<DoctorRemoteDataSource>()));

  // // Remote Usecases
  // getIt.registerLazySingleton<CreateDoctorUseCase>(() =>
  //     CreateDoctorUseCase(
  //         doctorRepository: getIt<DoctorRemoteRepository>()));

  getIt.registerLazySingleton<GetAllDoctorsUseCase>(() =>
      GetAllDoctorsUseCase(doctorRepository: getIt<DoctorRemoteRepository>()));

  // getIt.registerLazySingleton<DeleteDoctorUseCase>(
  //   () => DeleteDoctorUseCase(
  //       doctorRepository: getIt<DoctorRemoteRepository>(),
  //       tokenSharedPrefs: getIt<TokenSharedPrefs>()),
  // );

  // getIt.registerLazySingleton<UpdateDoctorUseCase>(
  //   () => UpdateDoctorUseCase(
  //       doctorRepository: getIt<DoctorRemoteRepository>(),
  //       tokenSharedPrefs: getIt<TokenSharedPrefs>()),
  // );

  // getIt.registerLazySingleton<GetDoctorByIdUseCase>(
  //   () => GetDoctorByIdUseCase(
  //       doctorRepository: getIt<DoctorRemoteRepository>()),
  // );

  // Bloc
  getIt.registerFactory<DoctorBloc>(
    () => DoctorBloc(
      // createDoctorUseCase: getIt<CreateDoctorUseCase>(),
      getAllDoctorsUseCase: getIt<GetAllDoctorsUseCase>(),
      // deleteDoctorUseCase: getIt<DeleteDoctorUseCase>(),
      // updateDoctorUseCase: getIt<UpdateDoctorUseCase>(),
    ),
  );
}

_initLoginDependencies() async {
  // =========================== Token Shared Preferences ===========================
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  // =========================== Usecases ===========================
  if (!getIt.isRegistered<LoginUseCase>()) {
    getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(
        authRepository: getIt<AuthRemoteRepository>(),
        tokenSharedPrefs: getIt<TokenSharedPrefs>(),
      ),
    );
  }

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      loginUseCase: getIt<LoginUseCase>(),
      signupBloc: getIt<SignupBloc>(),
      homeCubit: getIt<HomeCubit>(),
    ),
  );
}

_initOnboardingDependencies() async {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(getIt<LoginBloc>()),
  );
}

_initSplashDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(),
  );
}
