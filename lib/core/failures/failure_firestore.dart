import '../core.dart';

class FailureFirestore implements Failure {

  @override
  late final String error;

  @override
  late final String message;

  FailureFirestore({
    String? message,
    String? error,
  }) {
    this.error = error ??= AppConstants.defaultErrorTitle;
    this.message = message ??= AppConstants.firebaseErrorMessage;
  }
}
