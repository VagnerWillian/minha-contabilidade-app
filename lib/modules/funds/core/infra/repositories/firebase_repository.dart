import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/core.dart';
import '../../domain/entities/brand_entity.dart';
import '../../domain/repositories/repository.dart';
import '../models/models.dart';

class FirebaseFundsRepository implements FundsRepository {

  final _docFundsRef =
      FirebaseFirestore.instance.collection('fundos');

  final _docBrandsRef = FirebaseFirestore.instance.collection('bandeiras');

  @override
  Future<List<FundEntity>> getAllFunds() async {
    try {
      List<FundEntity> list = [];
      QuerySnapshot queryCreditSnapshot = await _docFundsRef.get();
      queryCreditSnapshot.docs
          .map((doc) => list.add(Fund.fromJson(
                (doc.data() as Map<String, dynamic>),
              )))
          .toList();
      list.sort((a, b) => b.order.compareTo(a.order));
      return list;
    } on FailureNetwork catch (_) {
      rethrow;
    } catch (err, stack) {
      throw FailureApp(message: err.toString(), stackTrace: stack);
    }
  }

  @override
  Future<List<BrandEntity>> getAllBrands() async {
    try {
      List<BrandEntity> list = [];
      QuerySnapshot queryCreditSnapshot = await _docBrandsRef.get();
      queryCreditSnapshot.docs
          .map((doc) => list.add(Brand.fromJson(
                (doc.data() as Map<String, dynamic>),
              )))
          .toList();
      return list;
    } on FailureNetwork catch (_) {
      return [
        Brand.failure(
          FailureNetwork(
            error: AppConstants.firebaseErrorTitle,
            message: 'Não foi possível criar a fatura do mês atual',
          ),
        )
      ];
    } on FirebaseException catch (_) {
      return [
        Brand.failure(
          FailureNetwork(
            error: AppConstants.firebaseErrorTitle,
            message: 'Não foi possível criar a fatura do mês atual',
          ),
        )
      ];
    } catch (err, stack) {
      return [
        Brand.failure(
          FailureApp(
            message: err.toString(),
            stackTrace: stack,
          ),
        )
      ];
    }
  }

  @override
  Future<void> createFund(Map<String, dynamic> data) async {
    try {
      await _docFundsRef.doc(data['id']).set(data);
    } on FailureNetwork catch (_) {
      throw FailureNetwork(
        error: AppConstants.firebaseErrorTitle,
      );
    } on FirebaseException catch (_) {
      throw FailureNetwork(
        error: AppConstants.firebaseErrorTitle,
      );
    } catch (err, stack) {
      throw FailureApp(
        message: err.toString(),
        stackTrace: stack,
      );
    }
  }

  @override
  Future<void> deleteFund(String id) async {
    try {
      await _docFundsRef.doc(id).delete();
    } on FailureNetwork catch (_) {
      throw FailureNetwork(
        error: AppConstants.firebaseErrorTitle,
      );
    } on FirebaseException catch (_) {
      throw FailureNetwork(
        error: AppConstants.firebaseErrorTitle,
      );
    } catch (err, stack) {
      throw FailureApp(
        message: err.toString(),
        stackTrace: stack,
      );
    }
  }
}
