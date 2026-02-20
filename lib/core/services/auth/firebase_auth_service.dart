import 'package:campus_hub/core/contracts/auth/auth_base.dart';
import 'package:campus_hub/core/contracts/auth/auth_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// [AuthBase] sözleşmesinin Firebase Authentication implementasyonu.
/// FirebaseAuth bağımlılığı yalnızca bu sınıfta kalır;
/// Bloc/UI katmanı yalnızca [AuthBase] arayüzünü görür.
final class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _auth;

  FirebaseAuthService({FirebaseAuth? auth})
    : _auth = auth ?? FirebaseAuth.instance;

  @override
  String? get currentUid => _auth.currentUser?.uid;

  @override
  Stream<String?> get authStateChanges =>
      _auth.authStateChanges().map((user) => user?.uid);

  // ──────────── SignIn ────────────

  @override
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      "Giriş yapıldı : ${result.user!.email}".infoLog();
      return result.user?.uid ?? '';
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapErrorCode(e.code));
    }
  }

  // ──────────── SignUp (henüz aktif değil) ────────────

  @override
  Future<String> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    throw UnimplementedError('SignUp henüz implemente edilmedi.');
  }

  // ──────────── SignOut ────────────

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // ──────────── Hata eşleme ────────────

  String _mapErrorCode(String code) {
    return switch (code) {
      'invalid-email' => 'Geçersiz e-posta adresi.',
      'user-not-found' => 'Bu e-posta ile kayıtlı kullanıcı bulunamadı.',
      'wrong-password' => 'Hatalı şifre girdiniz.',
      'too-many-requests' =>
        'Çok fazla deneme yaptınız. Lütfen daha sonra tekrar deneyin.',
      'user-disabled' => 'Bu hesap devre dışı bırakılmış.',
      'invalid-credential' => 'Geçersiz kimlik bilgileri.',
      'network-request-failed' => 'İnternet bağlantınızı kontrol edin.',
      _ => 'Giriş sırasında bir hata oluştu.',
    };
  }
}
