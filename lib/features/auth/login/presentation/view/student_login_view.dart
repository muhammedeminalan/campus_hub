import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

class StudentLoginView extends StatefulWidget {
  const StudentLoginView({super.key});

  @override
  State<StudentLoginView> createState() => _StudentLoginViewState();
}

class _StudentLoginViewState extends State<StudentLoginView>
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
          name: 'studentEmail',
          type: CustomFieldType.email,
          controller: _emailController,
          label: AppStrings.studentNumber,
        ),
        AppSize.v16.height,
        CustomTextField(
          name: 'studentPassword',
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
          isLoading: state is LoginLoading,
          text: AppStrings.login,
          textStyle: context.textTheme.labelLarge?.copyWith(fontWeight: .bold),
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
