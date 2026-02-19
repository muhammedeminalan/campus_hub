import 'package:campus_hub/config/init/app_init.dart';
import 'package:campus_hub/config/init/injection_container.dart';
import 'package:campus_hub/config/providers/bloc_providers.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/auth/login/presentation/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  AppInit.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProviders.providers,
      child: MaterialApp(
        title: AppStrings.appName,
        theme: sl<ThemeData>(),

        debugShowCheckedModeBanner: false,
        home: const LoginView(),
      ),
    );
  }
}
