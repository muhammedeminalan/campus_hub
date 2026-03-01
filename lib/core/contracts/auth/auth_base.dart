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

  /// Kayıt akışı ilerleyen sürümlerde [ISignUpCapable] arayüzü ile
  /// ayrı bir implementasyon olarak eklenecektir.

  Future<void> signOut();
}
