import 'package:campus_hub/core/contracts/auth/auth_base.dart';
import 'package:campus_hub/core/contracts/auth/auth_exception.dart';
import 'package:campus_hub/core/contracts/auth/i_token_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// [AuthBase] sözleşmesinin Firebase Authentication implementasyonu.
/// FirebaseAuth bağımlılığı yalnızca bu sınıfta kalır;
/// Bloc/UI katmanı yalnızca [AuthBase] arayüzünü görür.
final class FirebaseAuthService implements AuthBase, ITokenProvider {
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
      final user = result.user;
      if (user == null) {
        throw const AuthException('Kimlik doğrulama başarısız.');
      }
      "Giriş yapıldı : ${user.email}".infoLog();
      return user.uid;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapErrorCode(e.code));
    }
  }

  // ──────────── Token ────────────

  /// Firebase ID token'u döndürür; oturum kapalıysa `null`.
  /// Token süresi dolmuşsa Firebase otomatik yeniler.
  @override
  Future<String?> getAccessToken() async =>
      await _auth.currentUser?.getIdToken();

  // ──────────── SignOut ────────────

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapErrorCode(e.code));
    }
  }

  // ──────────── Hata eşleme ────────────

  String _mapErrorCode(String code) {
    return switch (code) {
      'invalid-email' => 'Geçersiz e-posta adresi.',
      // Kullanıcı enumeration açığını kapatmak için üç hata kodu
      // tek mesajda birleştirildi; saldırgan hangi bilginin yanlış
      // olduğunu ayırt edemez.
      'user-not-found' ||
      'wrong-password' ||
      'invalid-credential' => 'E-posta veya şifre hatalı.',
      'too-many-requests' =>
        'Çok fazla deneme yaptınız. Lütfen daha sonra tekrar deneyin.',
      'user-disabled' => 'Bu hesap devre dışı bırakılmış.',
      'network-request-failed' => 'İnternet bağlantınızı kontrol edin.',
      _ => 'Giriş sırasında bir hata oluştu.',
    };
  }
}
