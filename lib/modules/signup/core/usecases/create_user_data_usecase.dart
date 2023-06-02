import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/core.dart';

class CreateUserDataUseCase{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> call(UserProfile userProfile)async{
    try {
      await _firestore.collection('usuarios').doc(userProfile.uid).set(userProfile.toJson);
      return true;
    } on FailureNetwork catch (_) {
      rethrow;
    } on FirebaseException catch (_) {
      throw FailureFirebase();
    } catch (err, stack) {
      throw FailureApp(
        message: err.toString(),
        error: 'Não foi possível criar dados do usuario',
        stackTrace: stack,
      );
    }
  }
}