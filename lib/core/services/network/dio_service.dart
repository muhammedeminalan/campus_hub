import 'package:campus_hub/core/contracts/auth/auth_base.dart';
import 'package:campus_hub/core/contracts/auth/i_token_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'network_exceptions.dart';

/// DioClient: Tüm HTTP isteklerini yöneten servis.
/// [ITokenProvider] ve [AuthBase] inject edilerek auth + 401 akışı
/// otomatik yönetilir.
class DioService {
  static final DioService _instance = DioService._internal();

  late final Dio _dio;
  ITokenProvider? _tokenProvider;
  AuthBase? _authBase;

  factory DioService() => _instance;

  /// Auth için gerekli bağımlılıkları DI tarafından enjekte eder.
  /// İlk [DioService()] çağrısından sonra bir kez çağrılmalıdır.
  void configure({
    required ITokenProvider tokenProvider,
    required AuthBase authBase,
  }) {
    _tokenProvider = tokenProvider;
    _authBase = authBase;
    _dio.interceptors
      ..removeWhere((i) => i is InterceptorsWrapper)
      ..add(_buildAuthInterceptor());
  }

  DioService._internal() {
    _dio = Dio(
      BaseOptions(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    /// Logging interceptor — yalnızca debug build'lerde aktif.
    /// requestBody: false — şifreler/tokenlar log'a düşmesin.
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: false,
          responseBody: false,
          requestHeader: false,
        ),
      );
    }
  }

  /// Token enjeksiyonu + 401'de otomatik signOut interceptoru.
  InterceptorsWrapper _buildAuthInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _tokenProvider?.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Token geçersiz — kullanıcıyı oturumdan çıkar
          await _authBase?.signOut();
        }
        handler.next(error);
      },
    );
  }

  /// GET isteği
  Future<dynamic> get(
    String url, { // artık full URL
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// POST isteği
  Future<dynamic> post(String url, {dynamic data}) async {
    try {
      final response = await _dio.post(url, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// PUT isteği
  Future<dynamic> put(String url, {dynamic data}) async {
    try {
      final response = await _dio.put(url, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// DELETE isteği
  Future<dynamic> delete(String url, {dynamic data}) async {
    try {
      final response = await _dio.delete(url, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Response yönetimi — sadece 2xx döndürür, diğer durumlarda throw eder.
  dynamic _handleResponse(Response response) {
    final statusCode = response.statusCode ?? 0;
    if (statusCode >= 200 && statusCode < 300) return response.data;
    throw _networkExceptionFrom(statusCode, response.statusMessage);
  }

  /// HTTP status kodu → [NetworkException] dönüşümü.
  NetworkException _networkExceptionFrom(int statusCode, String? message) {
    return switch (statusCode) {
      400 => BadRequestException(message ?? 'Bad Request'),
      401 => UnauthorizedException(message ?? 'Unauthorized'),
      403 => UnauthorizedException(message ?? 'Forbidden'),
      404 => NotFoundException(message ?? 'Not Found'),
      500 ||
      502 ||
      503 => InternalServerErrorException(message ?? 'Server Error'),
      _ => UnknownException(message ?? 'Unknown Error ($statusCode)'),
    };
  }

  /// [DioException] → [NetworkException] dönüşümü.
  NetworkException _handleDioError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return DeadlineExceededException();
    }
    if (error.type == DioExceptionType.cancel) {
      return NetworkException('Request Cancelled');
    }
    if (error.response != null) {
      return _networkExceptionFrom(
        error.response!.statusCode ?? 0,
        error.response!.statusMessage,
      );
    }
    return UnknownException(error.message ?? 'Unknown Error');
  }
}
