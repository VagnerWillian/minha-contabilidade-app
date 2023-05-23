import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/core.dart';
import '../../domain/entities/entities.dart';

class SummaryTransaction implements SummaryTransactionEntity {

  @override
  late final Failure? failure;

  @override
  late final String id;

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

  SummaryTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idFund = json['idFundo'];
    paid = json['pago'];
    totally = json['total'];
    year = json['ano'];
    month = json['numeroMes'];
    expireDate = (json['vencimento'] as Timestamp).toDate();
    closeDate = (json['fechamento'] as Timestamp).toDate();
    failure = null;
  }

  SummaryTransaction.failure(this.failure, this.idFund);
}
