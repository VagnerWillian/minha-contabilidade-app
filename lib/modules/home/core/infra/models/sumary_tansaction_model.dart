import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/entities.dart';

class SummaryTransaction implements SummaryTransactionEntity{

  @override
  late final int id;

  @override
  late final String idFund;

  @override
  late final bool paid;

  @override
  late final int totally;

  @override
  late final int year;

  @override
  late final int month;

  @override
  late final DateTime expireDate;

  @override
  late final DateTime closeDate;

  SummaryTransaction({
    required this.id,
    required this.idFund,
    required this.paid,
    required this.totally,
    required this.year,
    required this.month,
    required this.expireDate,
    required this.closeDate,
});

  SummaryTransaction.fromJson(Map<String, dynamic> json){
    id = json['id'];
    idFund = json['idFundo'];
    paid = json['pago'];
    totally = json['total'];
    year = json['ano'];
    month = json['numeroMes'];
    expireDate = DateTime.fromMillisecondsSinceEpoch(json['vencimento'].seconds * 1000);
    closeDate = DateTime.fromMillisecondsSinceEpoch(json['fechamento'].seconds * 1000);  }
}