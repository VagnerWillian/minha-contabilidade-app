abstract class ConfigLocalServiceInterface {
  Future<bool> getFirstAccess();
  Future<bool> setFirstAccess(bool value);
  Future<String> saveLoginData(String value);
  Future<String> getLoginData();
  Future<String> saveUUIDData(String value);
  Future<String> getUIDData();
}
