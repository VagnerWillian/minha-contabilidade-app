import '../../../../../core/core.dart';

abstract class UsersRepository {
  Future<List<UserEntity>> getAllUsers();
  Future<List<FundEntity>> getAllFunds();
  Future<void> activeUser(String uid, bool active);
  Future<void> updateFundsFromUser(String uid, List<dynamic> funds);
}