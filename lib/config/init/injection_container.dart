import 'package:campus_hub/core/cache/shared_prefs_service.dart';
import 'package:campus_hub/features/login/presentation/bloc/login_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // --- Cache ---
  final sharedPrefsService = SharedPrefsService.instance;
  await sharedPrefsService.init();
  sl.registerLazySingleton<SharedPrefsService>(() => sharedPrefsService);

  // --- Network ---
  sl.registerLazySingleton<Dio>(() => Dio());

  // --- Bloc ---
  sl.registerFactory<LoginBloc>(() => LoginBloc());
}
