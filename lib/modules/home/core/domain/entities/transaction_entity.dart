abstract class SummaryTransactionEntity{
  late int id;
  late String idFund;
  late int year;
  late int month;
  late bool paid;
  late int totally;
  late DateTime expireDate;
  late DateTime closeDate;
}

abstract class TransactionEntity{
  late String id;
  late String idFund;
  late String name;
  late String date;
  late bool isPurchase;
  late int price;
}