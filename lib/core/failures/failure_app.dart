import '../core.dart';

class FailureApp implements Failure {
  final StackTrace stackTrace;

  @override
  late final String error;

  @override
  late final String message;

  FailureApp({
    this.error = AppConstants.defaultErrorTitle,
    required this.message,
    this.stackTrace = StackTrace.empty,
  });
}
