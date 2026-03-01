import 'package:campus_hub/core/contracts/auth/auth_base.dart';
import 'package:campus_hub/core/contracts/auth/auth_exception.dart';

/// E-posta / şifre ile oturum açma iş mantığını sarmalayan use case.
///
/// BLoC katmanı doğrudan [AuthBase]'e bağlı kalmak yerine bu use case
/// üzerinden çalışır; böylece auth servisi değişse de BLoC etkilenmez.
final class SignInUseCase {
  const SignInUseCase({required AuthBase authBase}) : _auth = authBase;

  final AuthBase _auth;

  /// Başarılı girişte `uid` döner, hata durumunda [AuthException] fırlatır.
  Future<String> call({required String email, required String password}) {
    if (email.trim().isEmpty) {
      throw const AuthException('E-posta alani bos birakilamaz.');
    }
    if (password.isEmpty) {
      throw const AuthException('Sifre alani bos birakilamaz.');
    }
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
