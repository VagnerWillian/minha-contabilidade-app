abstract class StorageAdapter{
  Future<void> init({required String container});
  Future<bool> readBool({required String key, bool defaultValue});
  Future<bool> writeBool({required String key, required bool value});
  Future<String> readString({required String key, String defaultValue});
  Future<String> writeString({required String key, required String value});
}