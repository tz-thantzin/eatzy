import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatzy/presentation/bloc/app/app_bloc.dart';
import 'package:eatzy/presentation/bloc/login/login_cubit.dart';
import 'package:eatzy/presentation/bloc/signup/signup_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/auth_datasource.dart';
import 'data/datasources/shared_preference_datasource.dart';
import 'data/datasources/user_profile_datasource.dart';
import 'data/implementation/auth_repository_impl.dart';
import 'data/implementation/shared_preference_impl.dart';
import 'data/implementation/user_profile_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/shared_preference_repository.dart';
import 'domain/repositories/user_profile_repository.dart';
import 'domain/usecases/auth_usecase.dart';
import 'domain/usecases/shared_preference_usecase.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Initialize shared preference datasource asynchronously
  final sharedPreference = await SharedPreferences.getInstance();
  final sharedPrefsDatasource = await SharedPreferenceDatasource.init(
    sharedPreference,
  );

  // Register shared preference repository implementation
  getIt.registerSingleton<SharedPreferenceRepository>(
    SharedPreferenceImpl(sharedPrefsDatasource),
  );

  // Register shared preference usecase
  getIt.registerSingleton<SharedPreferenceUseCase>(
    SharedPreferenceUseCase(getIt<SharedPreferenceRepository>()),
  );

  // Data sources
  getIt.registerLazySingleton<AuthDatasource>(
    () => AuthDatasource(
      firebaseAuth: FirebaseAuth.instance,
      googleSignIn: GoogleSignIn.instance,
    ),
  );

  getIt.registerLazySingleton<UserProfileDatasource>(
    () => UserProfileDatasource(
      firestore: FirebaseFirestore.instance,
      firebaseAuth: FirebaseAuth.instance,
    ),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthDatasource>()),
  );

  getIt.registerLazySingleton<UserProfileRepository>(
    () => UserProfileRepositoryImpl(getIt<UserProfileDatasource>()),
  );

  // Use Cases
  getIt.registerLazySingleton<AuthUseCase>(
    () => AuthUseCase(
      authRepository: getIt<AuthRepository>(),
      userProfileRepository: getIt<UserProfileRepository>(),
    ),
  );

  // Cubit
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(authUseCase: getIt<AuthUseCase>()),
  );

  getIt.registerFactory<SignupCubit>(
    () => SignupCubit(authUseCase: getIt<AuthUseCase>()),
  );

  // Bloc
  getIt.registerFactory<AppBloc>(
    () => AppBloc(
      authUseCase: getIt<AuthUseCase>(),
      sharePreferenceUseCase: getIt<SharedPreferenceUseCase>(),
    )..add(UserSubscriptionRequested()),
  );
}
