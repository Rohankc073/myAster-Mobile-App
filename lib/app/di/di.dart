import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:myAster/app/shared_prefs/token_shared_prefs.dart';
import 'package:myAster/app/shared_prefs/user_shared_prefs.dart';
import 'package:myAster/core/network/api_service.dart';
import 'package:myAster/core/network/hive_service.dart';
import 'package:myAster/features/auth/data/datasource/local_data_source/local_data_source.dart';
import 'package:myAster/features/auth/data/datasource/remote_data_source/remote_data_source.dart';
import 'package:myAster/features/auth/data/repository/auth_local_repository.dart';
import 'package:myAster/features/auth/data/repository/auth_remote_repository.dart';
import 'package:myAster/features/auth/domain/use_case/get_otp_usecase.dart';
import 'package:myAster/features/auth/domain/use_case/login_use_case.dart';
import 'package:myAster/features/auth/domain/use_case/reset_password_usecase.dart';
import 'package:myAster/features/auth/domain/use_case/signup_use_case.dart';
import 'package:myAster/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:myAster/features/auth/presentation/view_model/login/bloc/login_bloc.dart';
import 'package:myAster/features/auth/presentation/view_model/request_otp/request_otp_bloc.dart';
import 'package:myAster/features/auth/presentation/view_model/reset_password/reset_password_bloc.dart';
import 'package:myAster/features/auth/presentation/view_model/signup/bloc/signup_bloc.dart';
import 'package:myAster/features/cart/data/data_source/cart_datasource.dart';
import 'package:myAster/features/cart/data/repository/cart_remote_repository.dart';
import 'package:myAster/features/cart/domain/use_case/add_product_usecase.dart';
import 'package:myAster/features/cart/presentation/view_model/cart_bloc.dart';
import 'package:myAster/features/doctor/data/data_source/local_datasource/doctor_local_data_source.dart';
import 'package:myAster/features/doctor/data/data_source/remote_datasource/doctor_remote_data_source.dart';
import 'package:myAster/features/doctor/data/repository/doctor_local_repository.dart';
import 'package:myAster/features/doctor/data/repository/doctor_remote_repository.dart';
import 'package:myAster/features/doctor/domain/use_case/get_all_doctor_usecase.dart';
import 'package:myAster/features/doctor/presentation/view_model/doctor_bloc.dart';
import 'package:myAster/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:myAster/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:myAster/features/product/data/data_source/local_datasource/product_local_data_source.dart';
import 'package:myAster/features/product/data/data_source/remote_datasource/product_remote_data_source.dart';
import 'package:myAster/features/product/data/repository/product_local_repository.dart';
import 'package:myAster/features/product/data/repository/product_remote_repository.dart';
import 'package:myAster/features/product/domain/use_case/get_all_product_usecase.dart';
import 'package:myAster/features/product/presentation/view_model/product_bloc.dart';
import 'package:myAster/features/splash/presentation/view_model/cubit/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();

  await _initLoginDependencies();
  await _initSignupDependencies();

  await _initRequestOtpDependencies();
  await _initResetPasswordDependencies();

  await _initCartDependencies();
  await _initOnboardingDependencies();
  await _initSplashDependencies();
  await _initHomeDependencies();
  await _initDoctorDependencies();
  await _initProductDependencies();
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

_initRequestOtpDependencies() {
  if (!getIt.isRegistered<GetOtpUseCase>()) {
    getIt.registerLazySingleton<GetOtpUseCase>(() => GetOtpUseCase(
          userRepository: getIt<AuthRemoteRepository>(),
        ));
  }

  getIt.registerFactory<RequestOtpBloc>(
    () => RequestOtpBloc(getOtpUseCase: getIt<GetOtpUseCase>()),
  );
}

_initResetPasswordDependencies() {
  getIt.registerLazySingleton<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(userRepository: getIt<AuthRemoteRepository>()),
  );

  getIt.registerFactory<ResetPasswordBloc>(
    () =>
        ResetPasswordBloc(resetPasswordUseCase: getIt<ResetPasswordUseCase>()),
  );
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );

  getIt.registerLazySingleton<UserSharedPrefs>(
    () => UserSharedPrefs(getIt<SharedPreferences>()),
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
        repository: getIt<AuthRemoteRepository>(),
        tokenSharedPrefs: getIt<TokenSharedPrefs>(),
        userSharedPrefs: getIt<UserSharedPrefs>(),
      ),
    );
  }

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      loginUseCase: getIt<LoginUseCase>(),
      signupBloc: getIt<SignupBloc>(),
      homeCubit: getIt<HomeCubit>(),
      requestOtpBloc: getIt<RequestOtpBloc>(),
    ),
  );
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

_initCartDependencies() {
  getIt.registerLazySingleton<CartDatasource>(
    () => CartDatasource(
        userSharedPrefs: getIt<UserSharedPrefs>(), dio: getIt<Dio>()),
  );
  getIt.registerLazySingleton<CartRemoteRepository>(
    () => CartRemoteRepository(cartDatasource: getIt<CartDatasource>()),
  );

  getIt.registerLazySingleton<AddProductUsecase>(
    () => AddProductUsecase(repository: getIt<CartRemoteRepository>()),
  );
  // getIt.registerLazySingleton<RemoveProductUsecase>(
  //   () => RemoveProductUsecase(repository: getIt<CartRemoteRepository>()),
  // );
  // getIt.registerLazySingleton<ClearCartUsecase>(
  //   () => ClearCartUsecase(repository: getIt<CartRemoteRepository>()),
  // );
  // getIt.registerLazySingleton<GetCartUsecase>(
  //   () => GetCartUsecase(repository: getIt<CartRemoteRepository>()),
  // );

  getIt.registerFactory<CartBloc>(
    () => CartBloc(
        addProductUsecase: getIt(),
        removeProductUsecase: getIt(),
        clearCartUsecase: getIt(),
        getCartUsecase: getIt()),
  );
}

// Product Dependencies

_initProductDependencies() async {
  // Local Data Source
  getIt.registerFactory<ProductLocalDataSource>(
      () => ProductLocalDataSource(getIt<HiveService>()));

  // Remote Data Source
  getIt.registerFactory<ProductRemoteDataSource>(
      () => ProductRemoteDataSource(getIt<Dio>()));

  // Local Repository
  getIt.registerLazySingleton<ProductLocalRepository>(() =>
      ProductLocalRepository(
          productLocalDataSource: getIt<ProductLocalDataSource>()));

  // Remote Repository
  getIt.registerLazySingleton<ProductRemoteRepository>(() =>
      ProductRemoteRepository(
          productRemoteDataSource: getIt<ProductRemoteDataSource>()));

  // // Remote Usecases
  // getIt.registerLazySingleton<CreateDoctorUseCase>(() =>
  //     CreateDoctorUseCase(
  //         doctorRepository: getIt<DoctorRemoteRepository>()));

  getIt.registerLazySingleton<GetAllProductsUseCase>(() =>
      GetAllProductsUseCase(
          productRepository: getIt<ProductRemoteRepository>()));

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
  getIt.registerFactory<ProductBloc>(
    () => ProductBloc(
      // createDoctorUseCase: getIt<CreateDoctorUseCase>(),
      getAllProductsUseCase: getIt<GetAllProductsUseCase>(),
      // deleteDoctorUseCase: getIt<DeleteDoctorUseCase>(),
      // updateDoctorUseCase: getIt<UpdateDoctorUseCase>(),
    ),
  );
}

_initOnboardingDependencies() async {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(
      getIt<LoginBloc>(),
      getIt<TokenSharedPrefs>(),
    ),
  );
}

_initSplashDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(),
  );
}
