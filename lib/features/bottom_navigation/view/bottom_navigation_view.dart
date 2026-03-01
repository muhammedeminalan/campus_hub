import 'package:campus_hub/config/theme/app_theme.dart';
import 'package:campus_hub/features/courses/presentation/courses_view.dart';
import 'package:campus_hub/features/home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

import '../../exam_results/presentation/exam_results.dart';
import '../../quick_menu/presentation/quick_menu.dart';
import '../cubit/navigation_cubit.dart';
import '../enum/page_type.dart';
import '../widgets/custom_bottom_nav.dart';

class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppTheme.statusBarStyle,
      child: Scaffold(
        body: _buildBody(),
        bottomNavigationBar: const CustomBottomNav(),
        floatingActionButton: _buildQrFab(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<NavigationCubit, NavigationTab>(
      builder: (_, state) => IndexedStack(
        index: state.index,
        children: const [
          HomeView(),
          CoursesView(),
          ExamResults(),
          QuickMenu(),
        ],
      ),
    );
  }

  Widget _buildQrFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        'QR kod tarama açıldı'.infoLog();
        CostumBottomSheet.show(
          context,
          title: 'QR Kod Tarama',
          isDraggable: true,
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          useSafeArea: true,
          children: [
            Icon(
              Icons.qr_code_scanner,
              size: 64,
              color: context.primaryColor,
            ).center,
          ],
        );
      },
      backgroundColor: context.primaryColor,
      shape: const CircleBorder(),
      child: Icon(Icons.qr_code_scanner, color: context.onPrimaryColor),
    );
  }
}
