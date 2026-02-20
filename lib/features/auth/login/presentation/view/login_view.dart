import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:campus_hub/features/auth/login/presentation/view/student_login_view.dart';
import 'package:campus_hub/features/auth/login/presentation/view/teacher_login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabCount, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: _onLoginStateChanged,
          child: _buildBody(isKeyboardOpen, context),
        ),
      ),
    );
  }

  // ──────────── Bloc Listener ────────────

  void _onLoginStateChanged(BuildContext context, LoginState state) {
    switch (state) {
      case LoginSuccess():
        // AuthGate stream'i otomatik yönlendirir; burada sadece klavye kapatılır.
        FocusManager.instance.primaryFocus?.unfocus();

      case LoginFailure(:final message):
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: message.text));

      default:
        break;
    }
  }

  // ──────────── Build ────────────

  Widget _buildBody(bool isKeyboardOpen, BuildContext context) {
    return [
      // Klavye durumuna göre logo animasyonlu açılıp kapanır
      _animatedSize(isKeyboardOpen),
      LoginTabBar(controller: _tabController),
      AppSize.v16.height,

      _tabViews(),
    ].column().safeArea();
  }

  AnimatedSize _animatedSize(bool isKeyboardOpen) {
    return AnimatedSize(
      duration: 400.ms,
      curve: Curves.easeInOut,
      child: isKeyboardOpen ? const SizedBox.shrink() : const LoginHeader(),
    );
  }

  Widget _tabViews() {
    return TabBarView(
      controller: _tabController,
      children: const [
        // ─── Öğrenci Tab İçeriği ───
        StudentLoginView(),
        // ─── Öğretmen Tab İçeriği ───
        TeacherLoginView(),
      ],
    ).expanded();
  }
}
