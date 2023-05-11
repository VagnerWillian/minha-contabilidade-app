abstract class NetworkAdapter {
  late final String baseUrl;
  late String defaultContentType;
  late Duration timeout;
  Future<ResponseInterface> get({String path, Map<String, dynamic>? query});
  Future<ResponseInterface> put({String path, Map<String, dynamic>? query, dynamic data});
  void init({String baseUrl, String defaultContentType, Duration timeout});
  void addResponseModifier();
  void addRequestModifier();
}

abstract class ResponseInterface {
  late dynamic data;
  late Uri? uri;
  late int? statusCode;
  late String method;
  bool get isOk;
}

class ResponseNetwork implements ResponseInterface {
  @override
  dynamic data;

  @override
  late final int? statusCode;

  @override
  late final Uri? uri;

  @override
  late final String method;

  @override
  bool get isOk => statusCode != null && statusCode! >= 200 && statusCode! <= 299;

  ResponseNetwork({
    required this.data,
    required this.statusCode,
    this.uri,
    this.method = '',
  });
}
