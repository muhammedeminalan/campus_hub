import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

class TeacherLoginView extends StatefulWidget {
  const TeacherLoginView({super.key});

  @override
  State<TeacherLoginView> createState() => _TeacherLoginViewState();
}

class _TeacherLoginViewState extends State<TeacherLoginView>
    with AutomaticKeepAliveClientMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: [
        CustomTextField(
          name: AppStrings.teacher,
          type: CustomFieldType.email,
          controller: _emailController,
          label: AppStrings.email,
          keyboardType: TextInputType.emailAddress,
        ),
        AppSize.v24.height,
        CustomTextField(
          name: 'teacherPassword',
          type: CustomFieldType.password,
          controller: _passwordController,
          label: AppStrings.password,
        ),
        AppSize.v24.height,
        _loginButton(context),
      ],
    ).paddingSymmetric(h: AppSize.v24, v: AppSize.v16);
  }

  Widget _loginButton(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return CostumButton(
          text: AppStrings.login,
          textStyle: context.textTheme.labelLarge?.copyWith(fontWeight: .bold),
          isLoading: state is LoginLoading,
          onPressed: _onLogin,
        );
      },
    );
  }

  void _onLogin() {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<LoginBloc>().add(
      LoginRequested(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }
}
