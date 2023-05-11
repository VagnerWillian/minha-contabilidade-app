import '../../../../../../utils/constants/app_constants.dart';
import '../../domain/entities/entities.dart';

class AuthCredentials implements AuthCredentialsEntity {
  @override
  late final String token;

  @override
  late final String error;

  @override
  late final bool isVerified;

  AuthCredentials({
    required this.token,
    required this.isVerified
  });

  AuthCredentials.failure({String? message}) {
    token = '';
    error = message ?? AppConstants.defaultLoginErrorTitle;
  }
}
