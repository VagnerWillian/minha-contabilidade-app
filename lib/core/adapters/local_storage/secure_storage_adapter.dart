import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core.dart';

class SecureStorage implements StorageAdapter {
  late FlutterSecureStorage _storage;

  @override
  Future<void> init({
    required String container,
  }) async {
    _storage = const FlutterSecureStorage();
  }

  @override
  Future<bool> readBool({
    required String key,
    bool defaultValue = false,
  }) async {
    var result = await _storage.read(key: key);
    return result == 'true';
  }

  @override
  Future<bool> writeBool({required String key, required bool value}) async {
    await _storage.write(key: key, value: value.toString());
    return value;
  }

  @override
  Future<String> readString({required String key, String defaultValue = ''}) async {
    return await _storage.read(key: key) ?? defaultValue;
  }

  @override
  Future<String> writeString({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
    return value;
  }
}
