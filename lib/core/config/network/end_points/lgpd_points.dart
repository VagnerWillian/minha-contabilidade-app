import '../../../core.dart';

class LGPDPoints implements LGPDPointsEntity{

  @override
 late final String getDocuments;

  @override
  late final String saveAcceptedDocuments;

  LGPDPoints.fromJson(Map<String, dynamic> json){
    getDocuments = json['lgpd_points']['get_verifica_lgpd'];
    saveAcceptedDocuments = json['lgpd_points']['post_grava_lgpd'];
  }

}