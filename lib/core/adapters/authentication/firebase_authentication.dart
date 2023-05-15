import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../core.dart';
import '../../ui/modals/auth_modal/core/domain/entities/entities.dart';
import '../../ui/modals/auth_modal/core/infra/models/models.dart';

class FirebaseAuthentication implements AuthenticationAdapter {
  late FirebaseAuth _firebaseAuth;

  FirebaseAuthentication() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  @override
  Future<AuthCredentialsEntity> signInWithEmailAndPassword(String email, String pass) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      if (userCredential.user != null) {
        String token = await userCredential.user!.getIdToken();
        String uid = userCredential.user!.uid;
        return AuthCredentials(
          uid: uid,
          token: token,
          isVerified: userCredential.user!.emailVerified,
        );
      }
      return AuthCredentials.failure();
    } on FirebaseAuthException catch (e) {
      return AuthCredentials.failure(
        message: FirebaseConstants.translateFirebaseMessageErr(e.message),
      );
    }
  }

  @override
  Future<AuthCredentialsEntity> signInWithPhoneAndPassword(String phoneNumber) async {
    await _firebaseAuth.signInWithPhoneNumber(phoneNumber);
    return AuthCredentials(uid: '', token: '', isVerified: true);
  }

  @override
  Future<String?> sendEmailVerification() async {
    try {
      if (_firebaseAuth.currentUser != null) {
        await _firebaseAuth.currentUser!.sendEmailVerification();
      }
      return null;
    } on FirebaseAuthException catch (err, stack) {
      var message = FirebaseConstants.translateFirebaseMessageErr(err.message);
      throw FailureApp(message: message, stackTrace: stack);
    } catch (e, stack) {
      throw FailureApp(
        message: AppConstants.defaultErrorMessage,
        stackTrace: stack,
      );
    }
  }

  @override
  Future<void> signOut() async {
    if (kDebugMode) {
      print('Logouting...');
    }
    return await _firebaseAuth.signOut();
  }
}
