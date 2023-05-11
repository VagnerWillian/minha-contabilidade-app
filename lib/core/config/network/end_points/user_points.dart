import '../../../core.dart';

class UserPoints implements UserPointsEntity{

  @override
  late final String getUser;

  UserPoints.fromJson(Map<String, dynamic> json) {
    getUser = json['usuario_points']['get_post_put_usuario'] ?? '';
  }

}