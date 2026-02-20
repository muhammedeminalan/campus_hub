abstract class AuthBase {
  /// Oturum açmış kullanıcının UID'si; yoksa `null`.
  String? get currentUid;

  /// Auth durumu değişikliklerini dinleyen stream.
  /// Kullanıcı giriş/çıkış yaptığında veya silindiğinde tetiklenir.
  Stream<String?> get authStateChanges;

  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<String> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
