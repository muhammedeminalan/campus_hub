import 'package:campus_hub/config/init/injection_container.dart';
import 'package:campus_hub/core/contracts/auth/auth_base.dart';
import 'package:campus_hub/features/auth/login/presentation/view/login_view.dart';
import 'package:campus_hub/features/student_information/presentation/view/student_information.dart';
import 'package:flutter/material.dart';

/// Auth durumunu anlık dinler.
/// Kullanıcı silinirse, çıkış yaparsa veya token geçersiz olursa
/// otomatik olarak [LoginView]'a yönlendirir.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: sl<AuthBase>().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final uid = snapshot.data;
        return uid != null ? const StudentInformation() : const LoginView();
      },
    );
  }
}
