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
  final GetAllUsersUseCase _getAllUsersUseCase;

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
    this._getAllUsersUseCase,
  );

  final List<SummaryTransactionEntity> _summaries = [];
  late PageController pageController;
  TabController? tabController;

  final funds = <FundEntity>[].obs;
  final summariesFromFund = <SummaryTransactionEntity>[].obs;
  final transactions = <TransactionEntity>[].obs;
  final users = RxList<UserEntity>();
  final selectedFund = Rxn<FundEntity>();
  final loadingFunds = true.obs;
  final loadingSummariesTransactions = true.obs;
  final loadingTransactions = true.obs;
  final _message = Rxn<MessageModel>();
  final selectedUser = Rxn<UserEntity>();

  DateTime todayNow = DateTime.now();
  int page = 0;
  CancellationToken? transactionFromUserCancellationToken;
  CancellationToken? transactionAllUserCancellationToken;
  int get initialIndex => page > summariesFromFund.length - 1 ? summariesFromFund.length - 1 : page;

  @override
  Future<void> onInit() async {
    selectedUser(authUserController.userLogged!);
    pageController = PageController();
    messageListener(_message);
    getAllDataFromSelectedUser();
    super.onInit();
  }

  Future<void> getAllDataFromSelectedUser() async {
    await getAllUsers();
    await getAllFunds();
    await getAllSummariesFromFunds();
    changeCard(0);
  }

  Future<void> handleTabChange() async {
    if (!tabController!.indexIsChanging) {
      // if (!selectedUser.value!.isAdmin) {
        await getTransactionsFromUser(
          summariesFromFund[tabController!.index],
          selectedUser.value!.uid,
        );
      // } else {
      //   await getTransactionsFromAllUsers(summariesFromFund[tabController!.index]);
      // }
    }
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
        selectedUser.value!.isAdmin,
        selectedUser.value!.cards,
      ))
      ..sort((a, b) => a.active ? -1 : 1);
    loadingFunds(false);
  }

  Future<void> getAllSummariesFromFunds() async {
    if (funds.isNotEmpty && funds.first.failure != null) {
      _defineError(funds.first.failure!);
    } else {
      _summaries.clear();
      await Future.wait(funds.map((f) async {
        // if(!selectedUser.value!.isAdmin) {
          await getSummaryFromUser(f.id, selectedUser.value!.uid);
        // }else{
        //   await getSummaryAllUsers(f.id);
        // }
        return f;
      }).toList());
    }
  }

  Future<void> _getTransactionsFromFirstSummary() async {
    var summary = summariesFromFund.singleWhere(
      (smr) => AppConstants().todayNow.isDateBetween(
            selectedFund.value!.closeDate
                .getFirstDate(smr.closeDate.getPreviousMonth())
                .subtract(const Duration(days: 1)),
            smr.closeDate,
          ),
    );
    page = summariesFromFund.indexOf(summary);

    // if (!selectedUser.value!.isAdmin) {
      await getTransactionsFromUser(summary, selectedUser.value!.uid);
    // } else {
    //   await getTransactionsFromAllUsers(summary);
    // }
  }

  Future<void> getTransactionsFromAllUsers(SummaryTransactionEntity summary) async {
    transactionAllUserCancellationToken?.cancel();
    transactionAllUserCancellationToken = CancellationToken();
    await Future.wait(users.map((user) async {
      await getTransactionsFromUser(summary, user.uid, cancellable: false);
      return user;
    }).toList())
        .asCancellable(transactionAllUserCancellationToken);
  }

  void _getListSummariesFromFund() {
    summariesFromFund
      ..clear()
      ..addAll(_summaries.where((smr) {
        return smr.idFund == selectedFund.value!.id;
      }).toList());
  }

  Future<void> getSummaryFromUser(String fundId, String uid) async {
    loadingSummariesTransactions(true);
    print('BUSCANDO SUMÁRIOS DO USUARIO ${uid.toUpperCase()}... ');
    _summaries.addAll(
      await _getAllSummaryFromFundUseCase(fundId, uid),
    );
    loadingSummariesTransactions(false);
  }

  Future<void> getSummaryAllUsers(String fundId) async {
    loadingSummariesTransactions(true);
    print('BUSCANDO SUMÁRIOS DE TODOS USUARIO... ');
    var list = [];
    await Future.wait(users.map((user) async {
      list.addAll(await _getAllSummaryFromFundUseCase(fundId, user.uid));
      return user;
    }).toList());
    print(list.length);
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
        selectedUser.value!.uid,
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
        selectedUser.value!.uid,
        summariesFromFund[page],
      );
      return true;
    } on Failure catch (err) {
      _defineError(err);
      return false;
    }
  }

  Future<void> getTransactionsFromUser(
    SummaryTransactionEntity summary,
    String uid, {
    bool cancellable = true,
  }) async {
    print('BUSCANDO TRANSAÇÕES DO USUARIO $uid');
    if (cancellable) transactionFromUserCancellationToken?.cancel();
    transactionFromUserCancellationToken = CancellationToken();
    try {
      loadingTransactions(true);
      transactions
        ..clear()
        ..addAll(await _getAllTransactionsUseCase(
          uid,
          summary.id,
          selectedFund.value!.id,
        ).asCancellable(transactionFromUserCancellationToken));
      reorderTransactionsList();
    } catch (_) {}

    if (transactions.isNotEmpty && transactions.first.failure != null) {
      _defineError(transactions.first.failure!);
    }
    loadingTransactions(false);
  }

  Future<void> createTransaction(TransactionEntity transaction,
      {SummaryTransactionEntity? summary}) async {
    print('CRIANDO TRANSAÇÃO...');
    try {
      var onSummary = summary ?? summariesFromFund[page];
      await _createTransactionUseCase(transaction);
      if (onSummary == summariesFromFund[page]) transactions.insert(0, transaction);
      onSummary.totally += transaction.price;
      if (!await _updateSummary()) onSummary.totally -= transaction.price;
    } on Failure catch (err) {
      _defineError(err);
    }
  }

  Future<bool> deleteTransaction(TransactionEntity transaction) async {
    print('DELETANDO TRANSAÇÃO...');
    try {
      await _deleteTransactionUseCase(transaction);
      transactions.removeWhere((trs) => trs.id == transaction.id);
      if (transaction.postponeDate == null) {
        summariesFromFund[page].totally -= transaction.price;
        if (!await _updateSummary()) summariesFromFund[page].totally += transaction.price;
      }
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

  Future<bool> postponeTransaction(TransactionEntity transaction) async {
    print('ADIANDO TRANSAÇÃO...');
    try {
      // Salva os dados da transação do resumo atual
      await _updateTransactionUseCase(transaction);
      summariesFromFund[page].totally -= transaction.price;
      if (!await _updateSummary()) summariesFromFund[page].totally += transaction.price;

      // Copia a transação para a próxima fatura
      var newTransaction = TransactionFund.copyFromTransaction(transaction);
      var nextSummary = summariesFromFund[page + 1];

      newTransaction
        ..summaryId = nextSummary.id
        ..postponeDate = null;
      await createTransaction(newTransaction, summary: nextSummary);
      tabController?.animateTo(page + 1, duration: const Duration(seconds: 1));

      reorderTransactionsList();
      return true;
    } on Failure catch (err) {
      _defineError(err);
      return false;
    } on RangeError {
      _defineError(
        FailureApp(
          message: 'Não é possível adiar esta transação ainda...',
        ),
      );
      return false;
    }
  }

  Future<void> getAllUsers() async {
    try {
      var list = await _getAllUsersUseCase();
      users
        ..clear()
        ..addAll(list);
    } on Failure catch (err) {
      _defineError(err);
    }
  }

  void reorderTransactionsList() {
    transactions.sort((a, b) {
      if (a.approvedDate == null && b.approvedDate != null) {
        return -1;
      } else if (a.approvedDate != null && b.approvedDate == null) {
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
    } else if (err is FailureFirebase) {
      _message(MessageModel.error(
        title: err.error,
        message: err.message,
      ));
    } else if (err is FailureApp) {
      _message(MessageModel.error(title: err.error, message: err.message));
    }
  }
}
