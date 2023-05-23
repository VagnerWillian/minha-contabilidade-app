import 'package:cloud_firestore/cloud_firestore.dart';

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
  late final num price;

  @override
  late final String id;

  @override
  late final String idFund;

  @override
  late final bool approved;

  @override
  late final String description;

  TransactionFund({
    required this.id,
    required this.idFund,
    required this.userName,
    required this.isPurchase,
    required this.date,
    required this.price,
    required this.approved,
    required this.description,
  });

  TransactionFund.fromJson(Map<String, dynamic> json){
    id = json['id'];
    idFund = json['idFundo'];
    isPurchase = json['compra'];
    userName = json['nomeUsuario'];
    date = (json['data'] as Timestamp).toDate().toString();
    price = json['preco'];
    approved = json['aprovado'];
    description = json['descricao'];
    failure = null;
  }

  TransactionFund.failure(this.failure){
    description = failure!.error;
    date = AppConstants.todayNow.toString();
  }
}

