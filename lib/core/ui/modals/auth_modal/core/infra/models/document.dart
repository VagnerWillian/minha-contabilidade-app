import '../../../../../../core.dart';
import '../../domain/entities/entities.dart';

class DocumentLGPD implements DocumentLGPDEntity {
  @override
  late final Failure? failure;

  @override
  late final String data;

  @override
  late final int id;

  @override
  late final int idInstitution;

  @override
  late final String name;

  @override
  late final String url;

  DocumentLGPD.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'];
    idInstitution = json['idInstituicao'];
    name = json['nome'];
    url = json['url'];
  }

  DocumentLGPD.failure(Failure this.failure);
}
