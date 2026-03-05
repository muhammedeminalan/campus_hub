import 'package:campus_hub/config/init/injection_container.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/contracts/auth/auth_base.dart';
import 'package:campus_hub/features/auth/login/presentation/view/login_view.dart';
import 'package:campus_hub/features/bottom_navigation/view/bottom_navigation_view.dart';
import 'package:flutter/material.dart';

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
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: AppSize.v48),
                  const SizedBox(height: AppSize.v16),
                  const Text(
                    'Bağlantı hatası oluştu.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSize.v8),
                  Text(
                    snapshot.error.toString(),
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSize.v24),
                  TextButton.icon(
                    onPressed: _retry,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Yeniden Dene'),
                  ),
                ],
              ),
            ),
          );
        }
        final uid = snapshot.data;
        return uid != null ? const BottomNavigationView() : const LoginView();
      },
    );
  }
}
