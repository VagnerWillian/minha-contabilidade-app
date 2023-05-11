import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../../core.dart';

class GetConnectNetwork implements NetworkAdapter {
  final GetConnect _getConnect;
  final AuthUserController _authUserController;

  GetConnectNetwork(this._getConnect, this._authUserController);

  @override
  late final String baseUrl;

  @override
  late final String defaultContentType;

  @override
  late final Duration timeout;

  @override
  Future<ResponseInterface> get({
    String path = '',
    Map<String, dynamic>? query,
  }) async {
    Response? response;
    response = await _getConnect.get(path, query: query);
    return ResponseNetwork(
        data: response.body,
        statusCode: response.statusCode,
        uri: response.request?.url,
        method: 'GET');
  }

  @override
  Future<ResponseInterface> put({
    String path = '',
    Map<String, dynamic>? query,
    data,
  }) async {
    Response? response;
    response = await _getConnect.put(
      path,
      data,
      query: query,
    );
    return ResponseNetwork(
        data: response.body,
        statusCode: response.statusCode,
        uri: response.request?.url,
        method: 'PUT');
  }

  @override
  void init({
    String baseUrl = '',
    String defaultContentType = '',
    Duration timeout = const Duration(seconds: 2000),
  }) {
    _getConnect
      ..baseUrl = baseUrl
      ..defaultContentType = defaultContentType
      ..timeout = timeout;
  }

  @override
  void addResponseModifier() {
    _getConnect.httpClient.addResponseModifier((request, response) {
      debugPrint('------------INIT REQUEST------------');
      debugPrint('[METHOD] : ${request.method.toUpperCase()}');
      debugPrint('[WHERE] => ${request.url}');
      debugPrint('[HEADERS] => ${request.headers}');
      debugPrint('------------------------------------\n');

      debugPrint('------------INIT RESPONSE------------');
      debugPrint('[STATUS CODE] : ${response.statusCode ?? ''}');
      debugPrint('[DATA] : ${jsonEncode(response.body)}');
      debugPrint('-------------------------------------');

      if (response.statusCode == 401) {

      }
      return response;
    });
  }

  @override
  void addRequestModifier() {
    _getConnect.httpClient.addRequestModifier<dynamic>((request) {
      if (_authUserController.loggedCredentials != null) {
        request.headers.addAll(
          {'Authorization': 'Bearer ${_authUserController.loggedCredentials!.token}'},
        );
      }
      return request;
    });
  }
}

class GetHttpError implements Exception {
  final int? statusCode;
  final dynamic data;
  final Uri uri;

  GetHttpError(this.statusCode, this.data, this.uri);
}
