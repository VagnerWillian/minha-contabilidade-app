abstract class RemoteConfigAdapter{
  Future<void> init();
  Future<void> fetchData();
  Future<dynamic> getDataFromKey({required String key});
  Future<bool> getBoolFromKey({required String key});
}