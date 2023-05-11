import '../../../core.dart';

class EndPoints implements EndPointsEntity {

  // Base
  @override
  late final String baseUrl;

  @override
  late final StartPointsEntity startPoints;

  @override
  late final LGPDPointsEntity lgpdPoints;

  @override
  late final UserPointsEntity userPoints;

  EndPoints.fromJson(Map<String, dynamic> json, String baseUrlVersion) {
    baseUrl = json['base_url'][baseUrlVersion] ?? '';
    startPoints = StartPoints.fromJson(json);
    userPoints = UserPoints.fromJson(json);
    lgpdPoints = LGPDPoints.fromJson(json);
  }
}
