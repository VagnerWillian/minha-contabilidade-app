import '../../core/adapters/adapters.dart';

abstract class NetworkServiceInterface{
  void init({String baseUrl});
  Future<ResponseInterface> get({String path = '', Map<String, dynamic>? query});
  Future<ResponseInterface> put({String path = '', Map<String, dynamic>? query, dynamic data});
}