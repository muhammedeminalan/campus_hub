import 'package:flutter_bloc/flutter_bloc.dart';

import '../enum/page_type.dart';

class NavigationCubit extends Cubit<NavigationTab> {
  NavigationCubit() : super(NavigationTab.home);

  void updateTab(NavigationTab tab) => emit(tab);
}
