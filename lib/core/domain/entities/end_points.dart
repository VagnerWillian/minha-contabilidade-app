abstract class StartPointsEntity {
  late String getSpecialties;
  late String getQueueFromSpecialty;
}

abstract class UserPointsEntity {
  late String getUser;
}

abstract class LGPDPointsEntity {
  late String getDocuments;
  late String saveAcceptedDocuments;
}

abstract class EndPointsEntity {
  late String baseUrl;
  late StartPointsEntity startPoints;
  late LGPDPointsEntity lgpdPoints;
  late UserPointsEntity userPoints;
}
