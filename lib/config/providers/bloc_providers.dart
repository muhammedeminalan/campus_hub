import 'package:campus_hub/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:campus_hub/features/bottom_navigation/cubit/navigation_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../init/injection_container.dart';

class BlocProviders {
  static List<BlocProvider> get providers => [
    BlocProvider<LoginBloc>(create: (_) => sl<LoginBloc>()),
    BlocProvider<NavigationCubit>(create: (_) => sl<NavigationCubit>()),
  ];
}
