import 'package:get/get.dart';

import '../../controllers/auth_user_controller.dart';
import 'core/domain/entities/entities.dart';
import 'core/usecases/usecases.dart';

class HomeController extends GetxController {
  final AuthUserController _authUserController;
  final GetAllFundsUseCase _getAllFundsUseCase;
  final GetSummaryFromFund _getAllSummaryFromFundUseCase;

  HomeController(
    this._authUserController,
    this._getAllFundsUseCase,
    this._getAllSummaryFromFundUseCase,
  );

  final List<SummaryTransactionEntity> _summaryTransactions = [];

  final funds = <FundEntity>[].obs;
  final summaryTransactionsFromFund = <SummaryTransactionEntity>[].obs;
  final selectedFund = Rxn<FundEntity>();
  final loadingSummariesTransactions = true.obs;

  DateTime todayNow = DateTime.now();

  void changeCard(int cardIndex) {
    if (cardIndex == 0) {
      selectedFund.value = null;
      summaryTransactionsFromFund.clear();
    } else if (cardIndex > 0) {
      selectedFund(funds[cardIndex - 1]);
      summaryTransactionsFromFund
        ..clear()
        ..addAll(_summaryTransactions.where((smr) {
          return smr.idFund == selectedFund.value!.id;
        }).toList());
    }
  }

  Future<void> getAllFunds() async {
    print('BUSCANDO FUNDOS...');
    funds
      ..clear()
      ..addAll(await _getAllFundsUseCase(
        _authUserController.userLogged!.isAdmin,
        _authUserController.userLogged!.cards,
      ));
    funds.map((f) async {
      _summaryTransactions.clear();
      await getSummary(f.id);
      return f;
    }).toList();
  }

  Future<void> getSummary(String fundId) async {
    loadingSummariesTransactions(true);
    print('BUSCANDO SUMÁRIOS...');
    _summaryTransactions.addAll(
      await _getAllSummaryFromFundUseCase(fundId, _authUserController.userLogged!.uid),
    );
    loadingSummariesTransactions(false);
  }
}
