import 'package:campus_hub/core/contracts/auth/auth_base.dart';

/// Oturum kapatma iş mantığını sarmalayan use case.
final class SignOutUseCase {
  const SignOutUseCase({required AuthBase authBase}) : _auth = authBase;

  final AuthBase _auth;

  Future<void> call() => _auth.signOut();
}
