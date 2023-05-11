import 'package:get/get.dart';

import '../core/core.dart';

class NetworkService extends GetxService implements NetworkServiceInterface {
  final NetworkAdapter _restAdapter;
  NetworkService(this._restAdapter);

  @override
  void init({String baseUrl = ''}) {
    _restAdapter..timeout = const Duration(minutes: 1)
      ..init(baseUrl: baseUrl)
      ..addResponseModifier()
      ..addRequestModifier();
    super.onInit();
  }

  @override
  Future<ResponseInterface> get({
    String path = '',
    Map<String, dynamic>? query,
  }) async {
    var response = await _restAdapter.get(
      path: path,
      query: query,
    );
    if (response.isOk) {
      return response;
    } else {
      throw FailureNetwork(
        statusCode: response.statusCode,
        data: response.data,
        path: response.uri?.path,
        method: response.method,
      );
    }
  }

  @override
  Future<ResponseInterface> put({
    String path = '',
    Map<String, dynamic>? query,
    data,
  }) async {
    var response = await _restAdapter.put(
      path: path,
      query: query,
    );
    if (response.isOk) {
      return response;
    } else {
      throw FailureNetwork(
        statusCode: response.statusCode,
        data: response.data,
        path: response.uri?.path,
        method: response.method,
      );
    }
  }
}
