import '../../../../../core/core.dart';

abstract class SummaryTransactionEntity{
  late Failure? failure;
  late String id;
  late String idFund;
  late int year;
  late int month;
  late bool paid;
  late int totally;
  late DateTime expireDate;
  late DateTime closeDate;
}

abstract class TransactionEntity{
  late Failure? failure;
  late String id;
  late String idFund;
  late String userName;
  late String description;
  late String date;
  late bool isPurchase;
  late bool approved;
  late num price;
}