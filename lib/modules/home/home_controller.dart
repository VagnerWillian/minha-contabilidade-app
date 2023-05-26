import 'package:cancellation_token/cancellation_token.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../../controllers/auth_user_controller.dart';
import '../../core/core.dart';
import 'core/domain/entities/entities.dart';
import 'core/infra/models/models.dart';
import 'core/usecases/usecases.dart';

class HomeController extends GetxController with MessagesMixin {
  final AuthUserController authUserController;
  final GetAllFundsUseCase _getAllFundsUseCase;
  final GetSummaryFromFund _getAllSummaryFromFundUseCase;
  final CreateSummaryFundUseCase _createSummaryFundUseCase;
  final UpdateSummaryFundUseCase _updateSummaryFundUseCase;
  final GetAllTransactionsUseCase _getAllTransactionsUseCase;
  final CreateTransactionUseCase _createTransactionUseCase;
  final UpdateTransactionUseCase _updateTransactionUseCase;
  final DeleteTransactionUseCase _deleteTransactionUseCase;

  HomeController(
    this.authUserController,
    this._getAllFundsUseCase,
    this._getAllSummaryFromFundUseCase,
    this._createSummaryFundUseCase,
    this._updateSummaryFundUseCase,
    this._getAllTransactionsUseCase,
    this._createTransactionUseCase,
    this._updateTransactionUseCase,
    this._deleteTransactionUseCase,
  );

  final List<SummaryTransactionEntity> _summaries = [];
  late PageController pageController;
  TabController? tabController;

  final funds = <FundEntity>[].obs;
  final summariesFromFund = <SummaryTransactionEntity>[].obs;
  final transactions = <TransactionEntity>[].obs;
  final selectedFund = Rxn<FundEntity>();
  final loadingFunds = true.obs;
  final loadingSummariesTransactions = true.obs;
  final loadingTransactions = true.obs;
  final _message = Rxn<MessageModel>();

  DateTime todayNow = DateTime.now();
  int page = 0;
  CancellationToken? transactionCancellationToken;
  int get initialIndex => page > summariesFromFund.length - 1 ? summariesFromFund.length - 1 : page;

  @override
  Future<void> onInit() async {
    pageController = PageController();
    messageListener(_message);
    await getAllFunds();
    getAllSummariesFromFunds();
    super.onInit();
  }

  Future<void> handleTabChange() async {
    if (!tabController!.indexIsChanging) getTransactions(summariesFromFund[tabController!.index]);
    page = tabController!.index;
  }

  Future<void> changeCard(int cardIndex) async {
    if (cardIndex == 0) {
      selectedFund.value = null;
      summariesFromFund.clear();
      transactions.clear();
    } else if (cardIndex > 0) {
      selectedFund(funds[cardIndex - 1]);
      await _verifyAndCreateSummaries();
      _getListSummariesFromFund();
      _getTransactionsFromFirstSummary();
    }
  }

  Future<void> getAllFunds() async {
    print('BUSCANDO FUNDOS...');
    loadingFunds(true);
    funds
      ..clear()
      ..addAll(await _getAllFundsUseCase(
        authUserController.userLogged!.isAdmin,
        authUserController.userLogged!.cards,
      ))
      ..sort((a, b) => a.active ? -1 : 1);
    loadingFunds(false);
  }

  void getAllSummariesFromFunds() {
    if (funds.isNotEmpty && funds.first.failure != null) {
      _defineError(funds.first.failure!);
    }
    funds.map((f) async {
      _summaries.clear();
      await getSummary(f.id);
      return f;
    }).toList();
  }

  void _getTransactionsFromFirstSummary() {
    var item = summariesFromFund.singleWhere(
      (smr) => AppConstants().todayNow.isDateBetween(
            selectedFund.value!.closeDate
                .getFirstDate(smr.closeDate.getPreviousMonth())
                .subtract(const Duration(days: 1)),
            smr.closeDate,
          ),
    );
    page = summariesFromFund.indexOf(item);
    getTransactions(item);
  }

  void _getListSummariesFromFund() {
    summariesFromFund
      ..clear()
      ..addAll(_summaries.where((smr) {
        return smr.idFund == selectedFund.value!.id;
      }).toList());
  }

  Future<void> getSummary(String fundId) async {
    loadingSummariesTransactions(true);
    print('BUSCANDO SUMÁRIOS...');
    _summaries.addAll(
      await _getAllSummaryFromFundUseCase(fundId, authUserController.userLogged!.uid),
    );
    loadingSummariesTransactions(false);
  }

  Future<void> _verifyAndCreateSummaries() async {
    var fund = selectedFund.value!;

    DateTime tmp = AppConstants().todayNow;
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

    _summaries.map((smr) {
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
      'id': newDate.format(AppConstants.monthUnderlineYearPattern),
      'ano': newDate.year,
      'numeroMes': newDate.month,
      'fechamento': Timestamp.fromDate(closeDate),
      'vencimento': Timestamp.fromDate(expireDate),
      'idFundo': fund.id,
      'pago': false,
      'total': 0,
    };
    SummaryTransactionEntity newSmr = SummaryTransaction.fromJson(data);
    try {
      await _createSummaryFundUseCase(
        authUserController.userLogged!.uid,
        selectedFund.value!.id,
        data,
      );
      _summaries.add(newSmr);
    } on Failure catch (err) {
      _defineError(err);
    }
  }

  Future<bool> _updateSummary() async {
    try {
      await _updateSummaryFundUseCase(
        authUserController.userLogged!.uid,
        summariesFromFund[page],
      );
      return true;
    } on Failure catch (err) {
      _defineError(err);
      return false;
    }
  }

  Future<void> getTransactions(SummaryTransactionEntity summary) async {
    print('BUSCANDO TRANSAÇÕES');
    transactionCancellationToken?.cancel();
    transactionCancellationToken = CancellationToken();
    try {
      loadingTransactions(true);
      transactions
        ..clear()
        ..addAll(await _getAllTransactionsUseCase(
          authUserController.userLogged!.uid,
          summary.id,
          selectedFund.value!.id,
        ).asCancellable(transactionCancellationToken));
      reorderTransactionsList();
    } catch (_) {}

    if (transactions.isNotEmpty && transactions.first.failure != null) {
      _defineError(transactions.first.failure!);
    }
    loadingTransactions(false);
  }

  Future<void> createTransaction(TransactionEntity transaction) async {
    print('CRIANDO TRANSAÇÃO...');
    try {
      await _createTransactionUseCase(transaction);
      transactions.insert(0, transaction);
      summariesFromFund[page].totally += transaction.price;
      if (!await _updateSummary()) summariesFromFund[page].totally -= transaction.price;
    } on Failure catch (err) {
      _defineError(err);
    }
  }

  Future<bool> deleteTransaction(TransactionEntity transaction) async {
    print('DELETANDO TRANSAÇÃO...');
    try {
      await _deleteTransactionUseCase(transaction);
      transactions.removeWhere((trs) => trs.id == transaction.id);
      summariesFromFund[page].totally -= transaction.price;
      if (!await _updateSummary()) summariesFromFund[page].totally += transaction.price;
      return true;
    } on Failure catch (err) {
      _defineError(err);
      return false;
    }
  }

  Future<bool> updateTransaction(TransactionEntity transaction) async {
    print('ATUALIZANDO TRANSAÇÃO...');
    try {
      await _updateTransactionUseCase(transaction);
      reorderTransactionsList();
      return true;
    } on Failure catch (err) {
      _defineError(err);
      return false;
    }
  }

  void reorderTransactionsList() {
    transactions.sort((a, b) {
      if (a.approvedDate.isEmpty && b.approvedDate.isNotEmpty) {
        return -1;
      } else if (a.approvedDate.isNotEmpty && b.approvedDate.isEmpty) {
        return 1;
      } else {
        return b.date.compareTo(a.date);
      }
    });
  }

  void _defineError(Failure err) {
    if (err is FailureNetwork) {
      _message(MessageModel.network(
        title: err.error,
        message: err.message,
        failureNetwork: err,
      ));
    } else if (err is FailureFirestore) {
      _message(MessageModel.error(
        title: err.error,
        message: err.message,
      ));
    } else if (err is FailureApp) {
      _message(MessageModel.error(
        title: err.error,
      ));
    }
  }
}
