import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/core.dart';
import '../../domain/repositories/repository.dart';

class FirestoreUsersRepository implements UsersRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<UserEntity>> getAllUsers() async {
    print('CARREGANDO USUARIOS...');
    try {
      List<UserEntity> list = [];
      QuerySnapshot queryUsers = await _firestore.collection('usuarios').get();
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

  @override
  Future<List<FundEntity>> getAllFunds() async {
    print('CARREGANDO FUNDOS...');
    try {
      List<FundEntity> list = [];
      QuerySnapshot queryUsers = await _firestore.collection('fundos').get();
      queryUsers.docs
          .map((doc) => list.add(Fund.fromJson(
                (doc.data() as Map<String, dynamic>),
              )))
          .toList();
      return list;
    } on FailureNetwork catch (_) {
      throw FailureNetwork(
        error: AppConstants.firebaseErrorTitle,
        message: 'Não foi possível carregar os fundos',
      );
    } on FirebaseException catch (_) {
      throw FailureFirebase(
        error: AppConstants.firebaseErrorTitle,
        message: 'Não foi possível carregar os fundos',
      );
    } catch (err, stack) {
      throw FailureApp(
        message: err.toString(),
        stackTrace: stack,
      );
    }
  }

  @override
  Future<void> activeUser(String uid, bool active) async {
    print('ATIVANDO USUARIO ${uid.toUpperCase()}');
    try {
      await _firestore.collection('usuarios').doc(uid).update({'ativo': active});
    } on FailureNetwork catch (_) {
      throw FailureNetwork(
        error: AppConstants.firebaseErrorTitle,
        message: 'Não foi possível carregar os fundos',
      );
    } on FirebaseException catch (_) {
      throw FailureFirebase(
        error: AppConstants.firebaseErrorTitle,
        message: 'Não foi possível carregar os fundos',
      );
    } catch (err, stack) {
      throw FailureApp(
        message: err.toString(),
        stackTrace: stack,
      );
    }
  }

  @override
  Future<void> updateFundsFromUser(String uid, List<dynamic> funds) async{
    print('ATUALIZANDO FUNDOS DO USUARIO ${uid.toUpperCase()}');
    try {
      await _firestore.collection('usuarios').doc(uid).update({'cards': funds});
    } on FailureNetwork catch (_) {
      throw FailureNetwork(
        error: AppConstants.firebaseErrorTitle,
        message: 'Não foi atualizar usuário',
      );
    } on FirebaseException catch (_) {
      throw FailureFirebase(
        error: AppConstants.firebaseErrorTitle,
        message: 'Não foi atualizar usuário',
      );
    } catch (err, stack) {
      throw FailureApp(
        message: err.toString(),
        stackTrace: stack,
      );
    }
  }
}
