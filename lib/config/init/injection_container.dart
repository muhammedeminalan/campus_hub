import 'package:campus_hub/config/theme/app_theme.dart';
import 'package:campus_hub/core/cache/shared_prefs_service.dart';
import 'package:campus_hub/core/contracts/auth/auth_base.dart';
import 'package:campus_hub/core/services/auth/firebase_auth_service.dart';
import 'package:campus_hub/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:campus_hub/features/bottom_navigation/cubit/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // --- Theme ---
  sl.registerLazySingleton<ThemeData>(() => AppTheme.light);

  // --- Cache ---
  final sharedPrefsService = SharedPrefsService.instance;
  await sharedPrefsService.init();
  sl.registerLazySingleton<SharedPrefsService>(() => sharedPrefsService);

  // --- Auth ---
  sl.registerLazySingleton<AuthBase>(() => FirebaseAuthService());

  // --- Bloc ---
  sl.registerFactory<LoginBloc>(() => LoginBloc(authService: sl<AuthBase>()));

  // --- Cubit ---
  sl.registerFactory<NavigationCubit>(() => NavigationCubit());
}
