import '../../../../core/core.dart';
import '../domain/repositories/repositories.dart';

class ApiSplashRepository implements SplashRepository{

  final NetworkServiceInterface _client;
  final RemoteConfigServiceInterface _remoteConfigService;
  ApiSplashRepository(this._client, this._remoteConfigService);

  @override
  Future<UserEntity> getUserData() async{
    try {
      var response = await _client.get(
        path: '',
      );
      return UserProfile.fromJson(response.data['result']);
    } on FailureNetwork catch (_) {
      rethrow;
    } catch (err, stack) {
      throw FailureApp(message: err.toString(), stackTrace: stack);
    }
  }
}