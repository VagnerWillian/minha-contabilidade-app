import '../../domain/entities/entities.dart';

class Transaction implements TransactionEntity {
  @override
  late final String date;

  @override
  late final bool isPurchase;

  @override
  late final String name;

  @override
  late final int price;

  @override
  late final String id;

  @override
  late final String idFund;

  Transaction({
    required this.id,
    required this.idFund,
    required this.name,
    required this.isPurchase,
    required this.date,
    required this.price,
  });

  Transaction.fromJson(Map<String, dynamic> json){
    id = json['id'];
    idFund = json['idFundo'];
    isPurchase = json['compra'];
    name = json['nome'];
    date = json['date'];
    price = json['preco'];
  }
}
