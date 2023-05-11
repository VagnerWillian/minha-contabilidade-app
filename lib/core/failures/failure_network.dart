import '../core.dart';

class FailureNetwork implements Failure {
  final int? statusCode;
  final String? path;
  final String? data;
  final String? method;

  @override
  late final String error;

  @override
  late final String message;

  FailureNetwork({
    this.statusCode = 6,
    String? message,
    String? error,
    this.path,
    this.data,
    this.method,
  }) {
    this.error = error ??= AppConstants.httpErrors[statusCode]![0];
    this.message = message ??= AppConstants.httpErrors[statusCode]![1];
  }
}
