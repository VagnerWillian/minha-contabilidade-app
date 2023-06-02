import '../core.dart';

class FailureFirebase implements Failure {

  @override
  late final String error;

  @override
  late final String message;

  FailureFirebase({
    String? message,
    String? error,
  }) {
    this.error = error ??= AppConstants.defaultErrorTitle;
    this.message = message ??= AppConstants.firebaseErrorMessage;
  }
}
