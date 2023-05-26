import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../core.dart';

class Fund extends GetxController with EquatableMixin implements FundEntity {
  @override
  late final Failure? failure;

  @override
  late bool active;

  @override
  late int closeDate;

  @override
  late String color;

  @override
  late int expireDate;

  @override
  late String id;

  @override
  late num limit;

  @override
  late String name;

  @override
  late String brandId;

  @override
  late String brandUrl;

  @override
  late bool isCredit;

  @override
  late String logo;

  @override
  late int order;

  @override
  bool get closeInSameMonth => expireDate < closeDate;

  @override
  String get isCreditString => isCredit ? 'CRÉDITO' : 'DÉBITO';

  Fund({
    required this.active,
    required this.closeDate,
    required this.color,
    required this.expireDate,
    required this.id,
    required this.limit,
    required this.name,
    required this.logo,
    required this.brandId,
    required this.brandUrl,
    required this.isCredit,
    required this.order,
    required this.failure,
  });

  Fund.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['nome'];
    active = json['ativo'];
    closeDate = json['fecha'];
    expireDate = json['vence'];
    color = json['cor'];
    limit = json['limite'];
    isCredit = json['credito'];
    brandId = json['bandeiraId'];
    brandUrl = json['bandeiraUrl'];
    logo = json['logo'];
    order = json['order'];
    failure = null;

    nameObs(name);
    colorObs(color);
    brandUrlObs(brandUrl);
    logoUrlObs(logo);
  }

  Fund.failure(this.failure) {
    color = '#FF0000';
    logo = '';
    isCredit = true;
    name = 'Erro';
    brandId = '';
  }

  factory Fund.empty() => Fund(
        active: true,
        closeDate: 1,
        color: '#666666',
        expireDate: 30,
        id: '',
        limit: 0.0,
        name: '',
        logo: '',
        isCredit: true,
        order: 0,
        brandId: '',
        brandUrl: '',
        failure: null,
      );

  @override
  Map<String, dynamic> get toJson => {
        'id': id,
        'nome': name,
        'ativo': active,
        'fecha': closeDate,
        'vence': expireDate,
        'cor': color,
        'limite': limit,
        'credito': isCredit,
        'bandeiraId': brandId,
        'bandeiraUrl': brandUrl,
        'logo': logo,
        'order': order,
      };

  @override
  late Rx<String> nameObs = ''.obs;

  @override
  late Rx<String> colorObs = ''.obs;

  @override
  late Rx<String> brandUrlObs = ''.obs;

  @override
  late Rx<String> logoUrlObs = ''.obs;

  @override
  List get props => [
        active,
        closeDate,
        color,
        expireDate,
        id,
        limit,
        name,
        logo,
        brandId,
        brandUrl,
        isCredit,
        order,
        failure,
      ];

  @override
  void generateId() {
    id = '${name.toLowerCase().replaceAll(' ', '_').remotePoints()}_${const Uuid().v4()}';
  }
}
