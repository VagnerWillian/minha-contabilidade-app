import '../../../../../core/core.dart';
import '../../domain/entities/entities.dart';

class CreditFund implements CreditFundEntity {
  @override
  late final bool active;

  @override
  late final int closeDate;

  @override
  late final String color;

  @override
  late final int expireDate;

  @override
  late final String id;

  @override
  late final int limit;

  @override
  late final String name;

  @override
  late final String brand;

  @override
  late final String type;

  @override
  late final String logo;

  @override
  late final int order;

  CreditFund({
    required this.active,
    required this.closeDate,
    required this.color,
    required this.expireDate,
    required this.id,
    required this.limit,
    required this.name,
    required this.logo,
    required this.type,
    required this.order,
  });

  CreditFund.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['nome'];
    active = json['ativo'];
    closeDate = json['fecha'];
    expireDate = json['vence'];
    color = json['cor'];
    limit = json['limite'];
    type = json['tipo'];
    brand = json['bandeira'];
    logo = json['logo'];
    order = json['order'];
  }

}