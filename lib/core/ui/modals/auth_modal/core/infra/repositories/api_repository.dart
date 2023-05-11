import '../../../../../../core.dart';
import '../../domain/repositories/repositories.dart';

class ApiAuthModalRepository implements AuthModalRepository {

  final NetworkServiceInterface _client;
  final RemoteConfigServiceInterface _remoteConfigService;
  ApiAuthModalRepository(this._client, this._remoteConfigService);

  @override
  Future<UserEntity> getUserData() async{
    try {
      var response = await _client.get(path: '');
      return UserProfile.fromJson(response.data['result']);
    } on FailureNetwork catch (_) {
      rethrow;
    } catch (err, stack) {
      throw FailureApp(message: err.toString(), stackTrace: stack);
    }
  }
}
