import 'package:get/get.dart';

import '../../core/core.dart';
import 'core/usecases/usecases.dart';

class UsersController extends GetxController with MessagesMixin {
  final GetAllUsersUseCase _getAllUsersUseCase;
  final GetAllFundsUseCase _getAllFundsUseCase;
  final ActiveUserUseCase _activeUserUseCase;
  final UpdateFundsFromUserUseCase _updateFundsFromUserUseCase;

  UsersController(this._getAllUsersUseCase, this._getAllFundsUseCase, this._activeUserUseCase,
      this._updateFundsFromUserUseCase);

  final _message = Rxn<MessageModel>();
  final loadingUsers = false.obs;
  final users = RxList<UserEntity>();
  final funds = RxList<FundEntity>();

  @override
  Future<void> onInit() async {
    messageListener(_message);
    _getAllUsers();
    _getAllFunds();
    super.onInit();
  }

  Future<void> _getAllUsers() async {
    try {
      loadingUsers(true);
      var list = await _getAllUsersUseCase();
      users
        ..clear()
        ..addAll(list);
    } on Failure catch (err) {
      _defineError(err);
    }
    loadingUsers(false);
  }

  Future<void> _getAllFunds() async {
    try {
      loadingUsers(true);
      var list = await _getAllFundsUseCase();
      funds
        ..clear()
        ..addAll(list);
    } on Failure catch (err) {
      _defineError(err);
    }
    loadingUsers(false);
  }

  Future<void> activeUser(UserEntity user, bool active) async {
    try {
      _activeUserUseCase(user.uid, active);
      user.active = active;
    } on Failure catch (err) {
      _defineError(err);
    }
    loadingUsers(false);
  }

  Future<bool> updateFundsFromUser(UserEntity user, List<dynamic> funds) async {
    try {
      await _updateFundsFromUserUseCase(user.uid, funds);
      return true;
    } on Failure catch (err) {
      _defineError(err);
      return false;
    }
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
