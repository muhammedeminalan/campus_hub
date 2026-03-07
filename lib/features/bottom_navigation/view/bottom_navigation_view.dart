import 'package:campus_hub/features/courses/presentation/view/courses_view.dart';
import 'package:campus_hub/features/home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exam_results/presentation/view/exam_results_view.dart';
import '../../quick_menu/presentation/view/quick_menu_view.dart';
import '../cubit/navigation_cubit.dart';
import '../enum/page_type.dart';
import '../widgets/custom_bottom_nav.dart';

class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBody(),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<NavigationCubit, NavigationTab>(
      builder: (_, state) => IndexedStack(
        index: state.index,
        children: const [
          HomeView(),
          CoursesView(),
          ExamResultsView(),
          QuickMenuView(),
        ],
      ),
    );
  }
}
