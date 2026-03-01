/// API isteklerinde kullanılacak access token'ı sağlayan sözleşme.
///
/// Firebase projesinde bu, ID token'ıdır.
/// OAuth tabanlı projelerde access/refresh token çiftidir.
abstract interface class ITokenProvider {
  /// Geçerli access token'ı döner; oturum kapalıysa `null`.
  Future<String?> getAccessToken();
}
