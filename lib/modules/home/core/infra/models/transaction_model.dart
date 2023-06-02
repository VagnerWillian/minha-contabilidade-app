import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/core.dart';
import '../../domain/entities/entities.dart';

class TransactionFund implements TransactionEntity {
  @override
  late final Failure? failure;

  @override
  late final String date;

  @override
  late final bool isPurchase;

  @override
  late final String userName;

  @override
  late final String userId;

  @override
  late String summaryId;

  @override
  late final num price;

  @override
  late final String id;

  @override
  late final String idFund;

  @override
  late Timestamp? approvedDate;

  @override
  late Timestamp? postponeDate;

  @override
  late final String description;

  TransactionFund(
      {required this.idFund,
      required this.userName,
      required this.userId,
      required this.summaryId,
      required this.isPurchase,
      required this.date,
      required this.price,
      required this.description,
      this.approvedDate,
      this.postponeDate,
      this.failure}) {
    generateId();
  }

  TransactionFund.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idFund = json['idFundo'];
    isPurchase = json['compra'];
    userName = json['nomeUsuario'];
    userId = json['idUsuario'];
    summaryId = json['idSumario'];
    date = (json['data'] as Timestamp).toDate().toString();
    price = json['preco'];
    approvedDate = json['dataAprovacao'];
    postponeDate = json['dataAdiamento'];
    description = json['descricao'];
    failure = null;
  }

  TransactionFund.failure(this.failure) {
    description = failure!.error;
    date = AppConstants().todayNow.toString();
    isPurchase = false;
    userName = 'ERRO!';
    price = 0.0;
    approvedDate = Timestamp.fromDate(AppConstants().todayNow);
    postponeDate = Timestamp.fromDate(AppConstants().todayNow);
    generateId();
  }

  @override
  Map<String, dynamic> get toJson => {
        'id': id,
        'idFundo': idFund,
        'compra': isPurchase,
        'nomeUsuario': userName,
        'idUsuario': userId,
        'idSumario': summaryId,
        'data': Timestamp.fromDate(DateTime.parse(date)),
        'preco': double.parse(price.toStringAsFixed(2)),
        'dataAprovacao': approvedDate,
        'dataAdiamento': postponeDate,
        'descricao': description
      };

  @override
  void generateId() {
    id = '${description.toLowerCase().replaceAll(' ', '_').remotePoints()}_${const Uuid().v4()}';
  }

  factory TransactionFund.copyFromTransaction(TransactionEntity transaction) {
    return TransactionFund(
      idFund: transaction.idFund,
      userName: transaction.userName,
      userId: transaction.userId,
      summaryId: transaction.summaryId,
      isPurchase: transaction.isPurchase,
      date: transaction.date,
      price: transaction.price,
      description: transaction.description,
      approvedDate: transaction.approvedDate,
      postponeDate: transaction.postponeDate
    );
  }
}
