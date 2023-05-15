import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/core.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repository.dart';
import '../models/models.dart';

class FirebaseHomeRepository implements HomeRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  var docCardsRef =
      FirebaseFirestore.instance.collection('fundos').doc('credito').collection('cartoes');
  var extractsRef = FirebaseFirestore.instance.collection('extrato');
  var docDebitRef =
      FirebaseFirestore.instance.collection('fundos').doc('debito').collection('contas');

  @override
  Future<List<FundEntity>> getAllFunds() async {
    try {
      List<FundEntity> list = [];
      QuerySnapshot queryCreditSnapshot = await docCardsRef.get();
      QuerySnapshot queryDebitSnapshot = await docDebitRef.get();
      queryCreditSnapshot.docs
          .map((doc) => list.add(
                CreditFund.fromJson(
                  (doc.data() as Map<String, dynamic>),
                ),
              ))
          .toList();
      queryDebitSnapshot.docs
          .map((doc) => list.add(
                DebitFund.fromJson(
                  (doc.data() as Map<String, dynamic>),
                ),
              ))
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
    QuerySnapshot summariesSnapshot =
        await extractsRef.doc(uid).collection('resumos').doc('fundos').collection(fundId).get();
    List<SummaryTransactionEntity> summaries = [];
    summariesSnapshot.docs.map((doc) {
      summaries.add(SummaryTransaction.fromJson(
        (doc.data() as Map<String, dynamic>),
      ));
    }).toList();
    return summaries;
  }
}
