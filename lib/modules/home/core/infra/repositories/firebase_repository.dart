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
    } on FailureNetwork catch (_) {
      rethrow;
    } catch (err, stack) {
      throw FailureApp(message: err.toString(), stackTrace: stack);
    }
  }

  @override
  Future<List<SummaryTransactionEntity>> getSummaryFromFund(String fundId, String uid) async {
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
  }

  @override
  Future<void> createSummaryFromFund(
    String uid,
    String fundId,
    String summaryId,
    Map<String, dynamic> data,
  ) async {
    await _extractsRef
        .doc(uid)
        .collection('resumos')
        .doc('fundos')
        .collection(fundId)
        .doc(summaryId)
        .set(data);
  }
}
