import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/core.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repository.dart';
import '../models/models.dart';

class FirebaseHomeRepository implements HomeRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final _docCardsRef =
      FirebaseFirestore.instance.collection('fundos').doc('credito').collection('cartoes');
  final _extractsRef = FirebaseFirestore.instance.collection('extrato');

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
      return [
        Fund.failure(FailureNetwork(
          error: AppConstants.firebaseErrorTitle,
          message: 'Não foi possível criar a fatura do mês atual',
        ))
      ];
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
          .collection('resumos')
          .doc('fundos')
          .collection(fundId)
          .orderBy('ano', descending: false)
          .get();
      List<SummaryTransactionEntity> summaries = [];
      summariesSnapshot.docs.map((doc) {
        summaries.add(SummaryTransaction.fromJson((doc.data() as Map<String, dynamic>)));
      }).toList();
      return summaries;
    } on FailureNetwork catch (err) {
      return [SummaryTransaction.failure(err, fundId)];
    } on FirebaseException catch (_) {
      return [
        SummaryTransaction.failure(
            FailureNetwork(
              error: AppConstants.firebaseErrorTitle,
              message: 'Não foi possível criar a fatura do mês atual',
            ),
            fundId)
      ];
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
    String summaryId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _extractsRef
          .doc(uid)
          .collection('resumos')
          .doc('fundos')
          .collection(fundId)
          .doc(summaryId)
          .set(data);
    } on FailureNetwork catch (err) {
      rethrow;
    } on FirebaseException catch (e) {
      throw FailureNetwork(
        error: AppConstants.firebaseErrorTitle,
        message: 'Não foi possível criar a fatura do mês atual',
      );
    } catch (err, stack) {
      throw FailureApp(
        message: err.toString(),
        error: 'Não foi possível criar a fatura do mês atual',
        stackTrace: stack,
      );
    }
  }
}
