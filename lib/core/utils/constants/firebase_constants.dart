class FirebaseConstants {
  /// [RemoteConfig]
  static String optionsKey = 'MANUTENCAO';

 /// [Crashlytics]
  static String appCrash = 'Problemas no aplicativo';
  static String seasonCrashRemoteConfig = 'Problema ao obter configuração remota';
  static String apiRequestCrash = 'Problema na solicitação';

  /// [Analytics]
  static String walkThroughEvent = 'walk_through_event';

  static String translateFirebaseMessageErr(String? value){
    switch (value) {
      case 'There is no user record corresponding to this identifier. The user may have been deleted.':
        return 'Este usuário foi deletado ou não existe.';
      case 'The password is invalid or the user does not have a password.':
        return 'A senha é inválida ou o usuário não possui uma senha.';
      case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
        return 'Tempo de resposta excedido, problemas com a internet.';
      case 'The email address is already in use by another account.':
        return 'Já existe uma conta associada a este email.';
      case 'Password should be at least 6 characters':
        return 'A senha deve possuir no mínimo 6 caracteres.';
      case 'Tivemos um problema':
        return 'Tivemos um problema';
      case 'Solicitação cancelada':
        return 'Solicitação cancelada';
      case 'An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.':
        return 'Jà existe uma conta com o mesmo e-mail vinculado ao seu facebook.';
      case 'We have blocked all requests from this device due to unusual activity. Try again later.':
        return 'Bloqueamos todas as solicitações deste dispositivo devido a atividades incomuns. Tente mais tarde.';
      case 'The user account has been disabled by an administrator.':
        return 'A conta de usuário foi desativada por um administrador.';
      case 'Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later.':
        return 'O acesso a esta conta foi temporariamente desativado devido a muitas tentativas de login malsucedidas. Você pode restaurá-lo imediatamente redefinindo sua senha ou pode tentar novamente mais tarde.';

    // ...
      default:
        return 'Houve um problema';
    }
  }

}
