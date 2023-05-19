import 'package:get/get.dart';

import '../../core.dart';

abstract class FundEntity{
  late Failure? failure;
  late String id;
  late String name;
  late String color;
  late bool isCredit;
  late String logo;
  late String brandId;
  late String brandUrl;
  late int order;
  late bool active;
  late int closeDate;
  late int expireDate;
  late num limit;

  late Rx<String> nameObs;
  late Rx<String> colorObs;
  late Rx<String> brandUrlObs;
  late Rx<String> logoUrlObs;

  String get isCreditString;
  bool get closeInSameMonth;
  Map<String, dynamic> get toJson;

}