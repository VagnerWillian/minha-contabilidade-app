import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_user_controller.dart';
import '../../core/core.dart';
import '../../core/utils/extensions/datetime.dart';
import 'core/domain/entities/entities.dart';
import 'core/infra/models/models.dart';
import 'core/usecases/usecases.dart';

class HomeController extends GetxController with MessagesMixin {
  final AuthUserController _authUserController;
  final GetAllFundsUseCase _getAllFundsUseCase;
  final GetSummaryFromFund _getAllSummaryFromFundUseCase;
  final CreateSummaryFundUseCase _createSummaryFundUseCase;

  HomeController(
    this._authUserController,
    this._getAllFundsUseCase,
    this._getAllSummaryFromFundUseCase,
    this._createSummaryFundUseCase,
  );

  final List<SummaryTransactionEntity> _summaryTransactions = [];
  late final PageController pageController;

  final funds = <FundEntity>[].obs;
  final summaryTransactionsFromFund = <SummaryTransactionEntity>[].obs;
  final selectedFund = Rxn<FundEntity>();
  final loadingFunds = true.obs;
  final loadingSummariesTransactions = true.obs;
  final loadingTransactions = true.obs;
  final _message = Rxn<MessageModel>();

  DateTime todayNow = DateTime.now();

  @override
  Future<void> onInit() async {
    messageListener(_message);
    getAllFunds();
    super.onInit();
  }

  Future<void> changeCard(int cardIndex) async {
    if (cardIndex == 0) {
      selectedFund.value = null;
      summaryTransactionsFromFund.clear();
    } else if (cardIndex > 0) {
      selectedFund(funds[cardIndex - 1]);
      await _verifyAndCreateSummaries();
      _getListSummariesFromFund();
    }
  }

  Future<void> getAllFunds() async {
    print('BUSCANDO FUNDOS...');
    loadingFunds(true);
    funds
      ..clear()
      ..addAll(await _getAllFundsUseCase(
        _authUserController.userLogged!.isAdmin,
        _authUserController.userLogged!.cards,
      ));

    if (funds.isNotEmpty && funds.first.failure == null) {
      funds.map((f) async {
        _summaryTransactions.clear();
        await getSummary(f.id);
        return f;
      }).toList();
    } else {
      _defineError(funds.first.failure!);
    }

    loadingFunds(false);
  }

  void _getListSummariesFromFund() {
    summaryTransactionsFromFund
      ..clear()
      ..addAll(_summaryTransactions.where((smr) {
        return smr.idFund == selectedFund.value!.id;
      }).toList());
  }

  Future<void> getSummary(String fundId) async {
    loadingSummariesTransactions(true);
    print('BUSCANDO SUMÁRIOS...');
    _summaryTransactions.addAll(
      await _getAllSummaryFromFundUseCase(fundId, _authUserController.userLogged!.uid),
    );
    loadingSummariesTransactions(false);
  }

  Future<void> _verifyAndCreateSummaries() async {
    var fund = selectedFund.value!;

    DateTime tmp = AppConstants.todayNow;
    var closeDate = fund.closeDate.getFirstDate(tmp);
    DateTime? saveDate;

    if (tmp.isAfter(closeDate) || tmp == closeDate) {
      closeDate = closeDate.getNextMonth();
      closeDate = fund.closeDate.getFirstDate(closeDate);
      saveDate = closeDate;
      if (!fund.closeInSameMonth) saveDate = closeDate.getPreviousMonth();
    } else {
      saveDate = closeDate;
      if (!fund.closeInSameMonth) saveDate = closeDate.getPreviousMonth();
    }

    print(
      'HOJE É DIA ${tmp.format(AppConstants.fullDateWithHourPattern)} '
      'E O PRÓXIMO FECHAMENTO DO FUNDO •${fund.name.toUpperCase()}'
      '• => ${closeDate.format(AppConstants.fullDateWithHourPattern)} '
      '=> ID: ${saveDate.month}_${saveDate.year}',
    );

    var expireDate = fund.expireDate.getFirstDate(closeDate);
    if (fund.closeInSameMonth) expireDate = expireDate.getNextMonth();

    _summaryTransactions.map((smr) {
      if (saveDate?.month == smr.month &&
          saveDate?.year == smr.year &&
          smr.idFund == selectedFund.value!.id) {
        saveDate = null;
      }
    }).toList();
    if (saveDate != null) {
      await _createSummary(selectedFund.value!, saveDate!, closeDate, expireDate);
    }
  }

  Future<void> _createSummary(
    FundEntity fund,
    DateTime newDate,
    DateTime closeDate,
    DateTime expireDate,
  ) async {
    print('CRIANDO REGISTRO DE NOVO SUMÁRIO COM ID $newDate');
    var data = {
      'id': int.parse('${newDate.month}${newDate.year}'),
      'ano': newDate.year,
      'numeroMes': newDate.month,
      'fechamento': Timestamp.fromDate(closeDate),
      'vencimento': Timestamp.fromDate(expireDate),
      'idFundo': fund.id,
      'pago': false,
      'total': 0
    };
    SummaryTransactionEntity newSmr = SummaryTransaction.fromJson(data);
    try {
      await _createSummaryFundUseCase(
        _authUserController.userLogged!.uid,
        selectedFund.value!.id,
        newDate.format(AppConstants.monthUnderlineYearPattern),
        data,
      );
      _summaryTransactions.add(newSmr);
    } on Failure catch (err) {
    _defineError(err);
    }
  }

  void _defineError(Failure err) {
    if (err is FailureNetwork) {
      _message(MessageModel.network(
        title: err.error,
        message: err.message,
        failureNetwork: err,
      ));
    } else if (err is FailureApp) {
      _message(MessageModel.error(
        title: err.error,
      ));
    }
  }
}
