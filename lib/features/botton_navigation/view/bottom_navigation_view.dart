import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

import '../cubit/navigation_cubit.dart';
import '../enum/page_type.dart';
import '../widgets/custom_bottom_nav.dart';

class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: const CustomBottomNav(),
      floatingActionButton: _buildQrFab(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBody() {
    return BlocBuilder<NavigationCubit, NavigationTab>(
      builder: (_, state) => switch (state) {
        NavigationTab.home => const Center(
          child: Text("home"),
        ), // TODO: HomeView
        NavigationTab.courses => const Center(
          child: Text("Alınan Dersler"),
        ), // TODO: CoursesView
        NavigationTab.examResults => const Center(
          child: Text("Sınav Sonuçları"),
        ), // TODO: ExamResultsView
        NavigationTab.quickMenu => const Center(
          child: Text("Hızlı Menü"),
        ), // TODO: QuickMenuView
      },
    );
  }

  Widget _buildQrFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // TODO: QR kod tarama işlemi
        'QR kod tarama açıldı'.infoLog();
      },
      backgroundColor: context.primaryColor,
      shape: const CircleBorder(),
      child: Icon(Icons.qr_code_scanner, color: context.onPrimaryColor),
    );
  }
}
