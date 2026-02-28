import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Tüm Bloc/Cubit olaylarını loglayan global observer.
/// Log'lar yalnızca debug build'lerde üretilir.
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    if (kDebugMode) log('onCreate: ${bloc.runtimeType}', name: 'Bloc');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (kDebugMode) log('onChange: ${bloc.runtimeType} → $change', name: 'Bloc');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) log('onError: ${bloc.runtimeType} → $error', name: 'Bloc');
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    if (kDebugMode) log('onClose: ${bloc.runtimeType}', name: 'Bloc');
  }
}
