import '../core.dart';

class FailureRemoteConfig implements Failure {
  @override
  late final String error;

  @override
  late final String message;

  FailureRemoteConfig({
    required Exception exception,
    required StackTrace stack,
    Map<String, dynamic> response = const {},
  }) {
    error = AppConstants.defaultErrorTitle;
    message = AppConstants.remoteConfigErrorMessage;
  }
}
