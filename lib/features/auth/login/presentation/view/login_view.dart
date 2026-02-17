import 'package:flutter/material.dart';

import '../../../../../core/utils/index.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Text('Login View', style: context.textTheme.headlineMedium),
      ),
    );
  }
}
