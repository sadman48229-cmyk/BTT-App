import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable implements Exception {
  final String message;
  final String? code;

  const AppException({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];

  factory AppException.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException(message: 'Connection timed out. Please check your internet.');
      case DioExceptionType.connectionError:
        return const NetworkException(message: 'No internet connection. Please check your network.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final data = e.response?.data;
        final errorMessage = data is Map ? data['error']?['message'] ?? 'Server error' : 'Server error';
        if (statusCode == 401) {
          return UnauthorizedException(message: 'Authentication failed: $errorMessage');
        } else if (statusCode == 429) {
          return const RateLimitException(message: 'Too many requests. Please wait a moment.');
        } else if (statusCode != null && statusCode >= 500) {
          return ServerException(message: 'Server error ($statusCode). Please try again.');
        }
        return ServerException(message: errorMessage.toString());
      default:
        return UnknownException(message: e.message ?? 'An unexpected error occurred');
    }
  }

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException({required super.message}) : super(code: 'NETWORK_ERROR');
}

class ServerException extends AppException {
  const ServerException({required super.message}) : super(code: 'SERVER_ERROR');
}

class UnauthorizedException extends AppException {
  const UnauthorizedException({required super.message}) : super(code: 'UNAUTHORIZED');
}

class RateLimitException extends AppException {
  const RateLimitException({required super.message}) : super(code: 'RATE_LIMIT');
}

class ValidationException extends AppException {
  const ValidationException({required super.message}) : super(code: 'VALIDATION_ERROR');
}

class NotFoundException extends AppException {
  const NotFoundException({required super.message}) : super(code: 'NOT_FOUND');
}

class CacheException extends AppException {
  const CacheException({required super.message}) : super(code: 'CACHE_ERROR');
}

class UnknownException extends AppException {
  const UnknownException({required super.message}) : super(code: 'UNKNOWN_ERROR');
}

class FreeLimitException extends AppException {
  const FreeLimitException({required super.message}) : super(code: 'FREE_LIMIT_REACHED');
}
