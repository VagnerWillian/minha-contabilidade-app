import '../../domain/entities/entities.dart';

class DebitFund implements DebitFundEntity {
  @override
  late final bool active;

  @override
  late final String color;

  @override
  late final String id;

  @override
  late final String name;

  @override
  late final String account;

  @override
  late final String agency;

  @override
  late final String type;

  @override
  late final String logo;

  @override
  late final String brand;

  @override
  late final int money;

  @override
  late final int order;

  DebitFund({
    required this.active,
    required this.account,
    required this.agency,
    required this.color,
    required this.id,
    required this.money,
    required this.name,
    required this.logo,
    required this.type,
    required this.order,
    required this.brand,
  });

  DebitFund.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['nome'];
    active = json['ativo'];
    account = json['conta'];
    agency = json['agencia'];
    color = json['cor'];
    money = json['saldo'];
    type = json['tipo'];
    logo = json['logo'];
    order = json['order'];
    brand = json['bandeira'];
  }
}
