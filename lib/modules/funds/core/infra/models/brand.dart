import '../../../../../core/failures/failure.dart';
import '../../domain/entities/entities.dart';

class Brand implements BrandEntity {
  @override
  late final Failure? failure;

  @override
  late final String id;

  @override
  late final String nome;

  @override
  late final String url;

  @override
  late final bool active;

  Brand({
    this.failure,
    required this.id,
    required this.active,
    required this.nome,
    required this.url,
  });

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['ativo'];
    nome = json['nome'];
    url = json['url'];
    failure = null;
  }

  Brand.failure(this.failure);

}
