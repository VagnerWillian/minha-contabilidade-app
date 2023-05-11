import '../../../core.dart';

class StartPoints implements StartPointsEntity{

  @override
  late final String getSpecialties;

  @override
  late final String getQueueFromSpecialty;

  StartPoints.fromJson(Map<String, dynamic> json) {
    getSpecialties = json['tela_inicial_fila']['get_especialidades'] ?? '';
    getQueueFromSpecialty = json['tela_inicial_fila']['get_fila_especialidade'] ?? '';
  }
}