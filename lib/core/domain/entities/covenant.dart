abstract class CovenantEntity{
  late int id;
  late String label;
  late String labelPlan;
  late int idCovenant;
  late int? idPlan;
  bool isDefault = false;

  Map<String, dynamic> get toJson;
}