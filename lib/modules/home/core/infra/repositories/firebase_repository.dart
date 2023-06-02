import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/core.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repository.dart';
import '../models/models.dart';

class FirebaseHomeRepository implements HomeRepository {

  final _docCardsRef = FirebaseFirestore.instance.collection('fundos');
  final _extractsRef = FirebaseFirestore.instance.collection('faturas');
  final _usersRef = FirebaseFirestore.instance.collection('usuarios');

  @override
  Future<List<FundEntity>> getAllFunds() async {
    try {
      List<FundEntity> list = [];
      QuerySnapshot queryCreditSnapshot = await _docCardsRef.get();
      queryCreditSnapshot.docs
          .map((doc) => list.add(Fund.fromJson(
                (doc.data() as Map<String, dynamic>),
              )))
          .toList();
      list.sort((a, b) => a.order.compareTo(b.order));
      return list;
    } on FailureNetwork catch (err) {
      return [Fund.failure(err)];
    } on FirebaseException catch (_) {
      return [Fund.failure(FailureFirebase())];
    } catch (err, stack) {
      return [
        Fund.failure(
          FailureApp(message: err.toString(), stackTrace: stack),
        )
      ];
    }
  }

  @override
  Future<List<SummaryTransactionEntity>> getSummaryFromFund(String fundId, String uid) async {
    try {
      QuerySnapshot summariesSnapshot = await _extractsRef
          .doc(uid)
          .collection('detalhes')
          .doc('fundos')
          .collection(fundId)
          .orderBy('ano', descending: false)
          .get();
      List<SummaryTransactionEntity> summaries = [];
      summariesSnapshot.docs.map((doc) {
        summaries.add(SummaryTransaction.fromJson((doc.data() as Map<String, dynamic>)));
      }).toList();
      summaries.sort((a, b) => DateTime(a.year, a.month).compareTo(DateTime(b.year, b.month)));
      return summaries;
    } on FailureNetwork catch (err) {
      return [SummaryTransaction.failure(err, fundId)];
    } on FirebaseException catch (_) {
      return [SummaryTransaction.failure(FailureFirebase(), fundId)];
    } catch (err, stack) {
      return [
        SummaryTransaction.failure(
          FailureApp(message: err.toString(), stackTrace: stack),
          fundId,
        )
      ];
    }
  }

  @override
  Future<void> createSummaryFromFund(
    String uid,
    String fundId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _extractsRef
          .doc(uid)
          .collection('detalhes')
          .doc('fundos')
          .collection(fundId)
          .doc(data['id'])
          .set(data);
    } on FailureNetwork catch (_) {
      rethrow;
    } on FirebaseException catch (_) {
      throw FailureFirebase();
    } catch (err, stack) {
      throw FailureApp(
        message: err.toString(),
        error: 'Não foi possível criar a fatura do mês atual',
        stackTrace: stack,
      );
    }
  }


  @override
  Future<void> updateSummaryFromFund(
      String uid,
      SummaryTransactionEntity summary,
      ) async {
    try {
      await _extractsRef
          .doc(uid)
          .collection('detalhes')
          .doc('fundos')
          .collection(summary.idFund)
          .doc(summary.id)
          .update(summary.toJson)
          .timeout(
        const Duration(seconds: AppConstants.firebaseTimeout),
        onTimeout: () => null,
      );
    } on FailureNetwork catch (_) {
      rethrow;
    } on FirebaseException {
      throw FailureFirebase();
    } catch (err, stack) {
      throw FailureApp(
        message: err.toString(),
        stackTrace: stack,
      );
    }
  }

  @override
  Future<List<TransactionEntity>> getAllTransactions(
    String uid,
    String summaryId,
    String fundId,
  ) async {
    try {
      List<TransactionFund> list = [];
      QuerySnapshot queryCreditSnapshot = await _extractsRef
          .doc(uid)
          .collection('gastos')
          .doc(summaryId)
          .collection('compras')
          .where('idFundo', isEqualTo: fundId)
          .get();

      queryCreditSnapshot.docs
          .map((doc) => list.add(
                TransactionFund.fromJson(
                  (doc.data() as Map<String, dynamic>),
                ),
              ))
          .toList();
      return list;
    } on FailureNetwork catch (_) {
      return [TransactionFund.failure(FailureFirebase())];
    } on FirebaseException catch (_) {
      return [TransactionFund.failure(FailureFirebase())];
    } catch (err, stack) {
      return [
        TransactionFund.failure(
          FailureApp(
            message: err.toString(),
            stackTrace: stack,
          ),
        )
      ];
    }
  }

  @override
  Future<void> createTransaction(TransactionEntity transaction) async {
    try {
      await _extractsRef
          .doc(transaction.userId)
          .collection('gastos')
          .doc(transaction.summaryId)
          .collection('compras')
          .doc(transaction.id)
          .set(transaction.toJson)
          .timeout(
            const Duration(seconds: AppConstants.firebaseTimeout),
            onTimeout: () => null,
          );
    } on FailureNetwork catch (_) {
      rethrow;
    } on FirebaseException catch (_) {
      throw FailureFirebase();
    } catch (err, stack) {
      throw FailureApp(
        message: err.toString(),
        stackTrace: stack,
      );
    }
  }

  @override
  Future<void> deleteTransaction(TransactionEntity transaction) async {
    try {
      await _extractsRef
          .doc(transaction.userId)
          .collection('gastos')
          .doc(transaction.summaryId)
          .collection('compras')
          .doc(transaction.id)
          .delete()
          .timeout(
            const Duration(seconds: AppConstants.firebaseTimeout),
            onTimeout: () => null,
          );
    } on FailureNetwork catch (_) {
      rethrow;
    } on FirebaseException {
      throw FailureFirebase();
    } catch (err, stack) {
      throw FailureApp(
        message: err.toString(),
        stackTrace: stack,
      );
    }
  }

  @override
  Future<void> updateTransaction(TransactionEntity transaction) async {
    try {
      await _extractsRef
          .doc(transaction.userId)
          .collection('gastos')
          .doc(transaction.summaryId)
          .collection('compras')
          .doc(transaction.id)
          .set(transaction.toJson)
          .timeout(
            const Duration(seconds: AppConstants.firebaseTimeout),
            onTimeout: () => null,
          );
    } on FailureNetwork catch (_) {
      rethrow;
    } on FirebaseException {
      throw FailureFirebase();
    } catch (err, stack) {
      throw FailureApp(
        message: err.toString(),
        stackTrace: stack,
      );
    }
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    print('CARREGANDO USUARIOS...');
    try {
      List<UserEntity> list = [];
      QuerySnapshot queryUsers = await _usersRef.get();
      queryUsers.docs
          .map((doc) => list.add(UserProfile.fromJson(
        (doc.data() as Map<String, dynamic>),
      )))
          .toList();
      return list;
    } on FailureNetwork catch (_) {
      throw FailureNetwork(
        error: AppConstants.firebaseErrorTitle,
        message: 'Não foi possível carregar os usuarios',
      );
    } on FirebaseException catch (_) {
      throw FailureFirebase(
        error: AppConstants.firebaseErrorTitle,
        message: 'Não foi possível carregar os usuarios',
      );
    } catch (err, stack) {
      throw FailureApp(
        message: err.toString(),
        stackTrace: stack,
      );
    }
  }
}
