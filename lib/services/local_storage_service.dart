import 'package:get/get.dart';

import '../../core/core.dart';

class ConfigLocalService extends GetxService implements ConfigLocalServiceInterface {
  late final StorageAdapter _configLocalStorage;

  Future<ConfigLocalServiceInterface> init() async {
    _configLocalStorage = SecureStorage();
    await _configLocalStorage.init(
      container: StorageServiceKeys.configContainer,
    );
    return this;
  }

  @override
  Future<bool> getFirstAccess() async {
    return await _configLocalStorage.readBool(
      key: StorageServiceKeys.firstAccess,
      defaultValue: true,
    );
  }

  @override
  Future<bool> setFirstAccess(bool value) async {
    return await _configLocalStorage.writeBool(
      key: StorageServiceKeys.firstAccess,
      value: value,
    );
  }

  @override
  Future<String> saveLoginData(String value) async {
    return await _configLocalStorage.writeString(
      key: StorageServiceKeys.rememberLoginData,
      value: value,
    );
  }

  @override
  Future<String> getLoginData() async {
    return await _configLocalStorage.readString(
      key: StorageServiceKeys.rememberLoginData,
    );
  }

  @override
  Future<String> getUIDData() async{
    return await _configLocalStorage.readString(
      key: StorageServiceKeys.token,
    );
  }

  @override
  Future<String> saveUUIDData(String value) async{
    return await _configLocalStorage.writeString(
      key: StorageServiceKeys.token,
      value: value,
    );
  }
}

class StorageServiceKeys {
  static const String configContainer = 'configContainer';
  static const String firstAccess = 'firstAccess';
  static const String userAccess = 'userAccess';
  static const String user = 'user';
  static const String rememberLoginData = 'rememberEmail';
  static const String rememberPass = 'rememberPass';
  static const String token = 'token';
}
