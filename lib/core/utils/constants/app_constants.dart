class AppConstants {
  static bool mockApp = false;
  // DateTime todayNow = DateTime.now();
  DateTime todayNow = DateTime(2023,07,03);

  /// [Language App]
  static String defaultLanguageApp = 'pt_BR';

  /// [Time delayed]
  static int splashAnimDelayInSeconds = 3;
  static int mockDelayed = 2;

  /// [Number Patterns]
  static String decimalNumber = '#00';

  /// [Number Patterns]
  static const firebaseTimeout = 5;

  /// [Default Messages]
  static const String defaultSuccessTitle = 'Tudo certo';
  static const String firebaseErrorTitle = 'Problemas com o banco de dados';
  static const String defaultErrorTitle = 'Ops, houve um problema!';
  static const String defaultWarningTitle = 'Atenção';
  static const String defaultErrorMessage = 'Ocorreu um erro, mas já estamos trabalhando para resolver.';
  static const String defaultCancelMessage = 'Cancelar';
  static const String defaultLoginErrorTitle = 'Não foi possível entrar';
  static const String remoteConfigErrorMessage = 'Problema na configuração remota';
  static const String firebaseErrorMessage = 'Problema ao obter dados do Firebase';
  static const String dataNotFound = 'Nenhum dado encontrado!';
  static const String errorImageLoad = 'Não foi possível carregar imagem, verifique sua conexão.';
  static const String unauthenticatedUser = 'Usuário não autenticado';
  static const String listFundsEmpty = 'Problema ao carregar fundos..';
  static const String listSummariesEmpty = 'Nenhum resumo de período carregou :(';
  static const String listTransactionsEmpty = 'Nenhuma compra realizada neste período';

  /// [Form Validators]
  static const String fieldRequired = 'Campo obrigatório';
  static const String invalidEmail = 'Email inválido';
  static const String invalidPhone = 'Celular inválido';
  static const String invalidCpf = 'CPF inválido';
  static const String minCharacters = 'Mínimo 8 caracteres';
  static const String passwordMatch = 'As senhas devem ser iguais';

  /// [Form Masks]
  static const String cpfMask = '999.999.999-99';

  /// [Date Patterns]
  static const String dayMonthPattern = 'dd/MM';
  static const String monthYearPattern = 'MM/yyyy';
  static const String monthUnderlineYearPattern = 'MM_yyyy';
  static const String monthYearCompressedPattern = 'MMM/yy';
  static const String monthYearInFullPattern = 'MMMM yyyy';
  static const String compressedDatePattern = 'dd/MM/yy';
  static const String fullDatePattern = 'dd/MM/yyyy';
  static const String extensiveNamedDatePattern = "d 'de' MMMM 'de' yyyy";
  static const String fullDateWithHourPattern = 'dd/MM/yyyy HH:mm';
  static const String monthPattern = 'MMMM';
  static const String hourPattern = 'HH:mm';
  static const String inFullDatePattern = 'dd MMMM y';
  static const String dateAndHourPattern = 'dd/MM/yy HH:mm';
  static const String dateFileNamePattern = 'dd_MM_yyyy_HH_mm_ss';

  /// [UTI compatibilities IOS openFileX]
  static const Map<String, String> iosUtiExtensions = {'.pdf': 'com.adobe.pdf'};

  /// [Internet Response Errors]
  static const Map<dynamic, List<String>> httpErrors = {
    // Generic Errors
    null : ['Você está offline', 'Verifique sua conexão com a internet e tente novamente.'],
    0 :    ['Tempo de limite esgotado', 'Os dados estão demorando para carregar, Verifique sua conexão e tenta novamente.'],
    1 :    ['Tempo de envio esgotado', 'Os dados estão demorando para carregar, Verifique sua conexão e tenta novamente.'],
    2 :    ['Tempo de recebimento esgotado', 'Os dados estão demorando para carregar, Verifique sua conexão e tenta novamente.'],
    6 :    ['Problema desconhecido', 'Ops! Tivemos um problema, nossa equipe já está resolvendo.'],

    // Errors from http Response
    401 : ['Sessão expirada', 'Solicitação não autorizada, sessão expirada, entre novamente para continuar.'],
    400:  ['Chave de acesso', 'Você precisa ativar a chave de acesso'],
    404 : ['Não encontrado', 'Não conseguimos localizar os dados da solicitação, tente novamente mais tarde.'],
    500 : ['Tivemos um problema', 'Erro no servidor interno'],
    503 : ['Tivemos um problema', 'Servidor indisponível'],
    999 : ['Configuração remota', 'Problema ao carregar configurações remotas. Tente novamente mais tarde.']
};
}
