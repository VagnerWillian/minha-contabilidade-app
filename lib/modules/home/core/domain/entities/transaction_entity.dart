import '../../../../../core/core.dart';

abstract class SummaryTransactionEntity{
  late Failure? failure;
  late String id;
  late String idFund;
  late int year;
  late int month;
  late bool paid;
  late num totally;
  late DateTime expireDate;
  late DateTime closeDate;
  Map<String, dynamic> get toJson;
}

abstract class TransactionEntity{
  late Failure? failure;
  late String id;
  late String idFund;
  late String userName;
  late String userId;
  late String summaryId;
  late String description;
  late String date;
  late bool isPurchase;
  late String approvedDate;
  late num price;
  Map<String, dynamic> get toJson;
  void generateId();
}