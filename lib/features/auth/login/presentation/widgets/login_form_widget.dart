import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Öğrenci ve Öğretmen tab'larında ortak kullanılan giriş formu.
///
/// DRY: İki tab aynı layout'u paylaşır; fark yalnızca e-posta alanı
/// label/name değerleridir.
class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({
    super.key,
    required this.emailFieldName,
    required this.emailLabel,
    this.emailKeyboardType,
  });

  final String emailFieldName;
  final String emailLabel;
  final TextInputType? emailKeyboardType;

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget>
    with AutomaticKeepAliveClientMixin {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

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
          name: widget.emailFieldName,
          type: CustomFieldType.email,
          controller: _emailController,
          label: widget.emailLabel,
          keyboardType: widget.emailKeyboardType,
        ),
        AppSize.v24.height,
        CustomTextField(
          name: '${widget.emailFieldName}_password',
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
      // Yalnızca loading durumu değişince button rebuild edilir.
      buildWhen: (prev, curr) =>
          (prev is LoginLoading) != (curr is LoginLoading),
      builder: (context, state) {
        return CustomButton(
          isLoading: state is LoginLoading,
          text: AppStrings.login,
          textStyle: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
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
