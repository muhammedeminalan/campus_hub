import 'package:campus_hub/config/init/app_bloc_observer.dart';
import 'package:campus_hub/config/init/injection_container.dart';
import 'package:campus_hub/features/login/presentation/bloc/login_bloc.dart';
import 'package:campus_hub/features/login/presentation/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => sl<LoginBloc>())],
      child: MaterialApp(
        title: 'CampusHub',
        theme: sl<ThemeData>(),
        debugShowCheckedModeBanner: false,
        home: const LoginView(),
      ),
    );
  }
}
