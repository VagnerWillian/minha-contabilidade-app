abstract class FundEntity{
  late String id;
  late String name;
  late String color;
  late String type;
  late String logo;
  late String brand;
  late int order;
  late bool active;
}

abstract class CreditFundEntity extends FundEntity{
  late int closeDate;
  late int expireDate;
  late int limit;
}

abstract class DebitFundEntity extends FundEntity{
  late int money;
  late String agency;
  late String account;
}