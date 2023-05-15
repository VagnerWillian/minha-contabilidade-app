import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../core.dart';
import '../../domain/repositories/repositories.dart';

class ApiAuthModalRepository implements AuthModalRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<UserEntity> getUserData(String uid) async{
    try {
    DocumentSnapshot docSnapshot = await _firebaseFirestore.collection('usuarios').doc(uid).get();
    return UserProfile.fromJson((docSnapshot.data() as Map<String, dynamic>));
    } on FailureNetwork catch (_) {
      rethrow;
    } catch (err, stack) {
      throw FailureApp(message: err.toString(), stackTrace: stack);
    }
  }
}
