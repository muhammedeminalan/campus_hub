/// Kimlik doğrulama işlemlerinde oluşan hataları temsil eder.
/// Bloc katmanı bu exception'ı yakalayarak kullanıcıya mesaj gösterir.
final class AuthException implements Exception {
  final String message;

  const AuthException(this.message);

  @override
  String toString() => message;
}
