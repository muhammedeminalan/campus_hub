import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/features/auth/login/presentation/view/student_login_view.dart';
import 'package:campus_hub/features/auth/login/presentation/view/teacher_login_view.dart';
import 'package:flutter/material.dart';

import '../widgets/login_header.dart';
import '../widgets/login_tab_bar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  static const _tabCount = 2;
  static const _tabBarBottomGap = AppSize.v16;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabCount, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const LoginHeader(),
              LoginTabBar(controller: _tabController),
              const SizedBox(height: _tabBarBottomGap),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    // ─── Öğrenci Tab İçeriği ───
                    StudentLoginView(),
                    // ─── Öğretmen Tab İçeriği ───
                    TeacherLoginView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
