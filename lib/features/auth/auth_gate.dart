import 'package:campus_hub/config/init/injection_container.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/contracts/auth/auth_base.dart';
import 'package:campus_hub/features/auth/login/presentation/view/login_view.dart';
import 'package:campus_hub/features/bottom_navigation/view/bottom_navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Auth durumunu anlık dinler.
/// Kullanıcı silinirse, çıkış yaparsa veya token geçersiz olursa
/// otomatik olarak [LoginView]'a yönlendirir.
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  /// Stream'i yeniden oluşturmak için anahtar; retry basıldığında
  /// setState ile güncellenerek builder'ın yeni bir stream dinlemesini sağlar.
  int _retryKey = 0;

  void _retry() => setState(() => _retryKey++);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      key: ValueKey(_retryKey),
      stream: sl<AuthBase>().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: const CircularProgressIndicator().center);
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: [
              const Icon(Icons.error_outline, size: AppSize.v48),
              AppSize.v16.h,

              'Bağlantı hatası oluştu.'.text.align(.center),

              AppSize.v8.h,

              snapshot.error
                  .toString()
                  .text
                  .fontSize(AppSize.v12)
                  .align(.center),

              AppSize.v24.h,
              TextButton.icon(
                onPressed: _retry,
                icon: const Icon(Icons.refresh),
                label: 'Yeniden Dene'.text,
              ),
            ].column(mainAxisSize: .min),
          ).center;
        }
        final uid = snapshot.data;
        return uid != null ? const BottomNavigationView() : const LoginView();
      },
    );
  }
}
