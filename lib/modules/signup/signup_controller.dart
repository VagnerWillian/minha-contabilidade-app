import 'package:get/get.dart';

import '../../core/core.dart';
import '../../core/ui/modals/auth_modal/core/domain/entities/auth_credentials.dart';
import 'core/usecases/usecases.dart';

class SignUpController extends GetxController with MessagesMixin {
  final CreateAccountWithEmailAndPassUseCase _createAccountPhoneUseCase;
  final CreateUserDataUseCase _createUserDataUseCase;

  final _message = Rxn<MessageModel>();

  SignUpController(
    this._createAccountPhoneUseCase,
    this._createUserDataUseCase,
  );

  @override
  void onInit() {
    messageListener(_message);
    super.onInit();
  }

  Future<bool> createAccountWithEmailAndPass(
    String email,
    String pass,
    String name,
    String cpf,
  ) async {
    AuthCredentialsEntity authCredentials = await _createAccountPhoneUseCase(email, pass);
    if (authCredentials.error.isNotEmpty) {
      _defineError(
        FailureFirebase(
          error: 'Não foi possível criar a conta',
          message: authCredentials.error,
        ),
      );
      return false;
    }

    return await _createUserData(uid: authCredentials.uid, name: name, cpf: cpf, email: email);
  }

  Future<bool> _createUserData({
    required String name,
    required String email,
    required String uid,
    required String cpf,
  }) async {
    var newUser = UserProfile(
      active: false,
      isAdmin: false,
      cpf: cpf,
      name: name,
      email: email,
      photo: '',
      pushToken: '',
      deviceId: '',
      uid: uid,
      cards: [],
    );

    try {
      await _createUserDataUseCase(newUser);
      return true;
    } on Failure catch (err) {
      _defineError(err);
      return false;
    }
  }

  void _defineError(Failure err) {
    if (err is FailureNetwork) {
      _message(MessageModel.network(
        title: err.error,
        message: err.message,
        failureNetwork: err,
      ));
    } else if (err is FailureFirebase) {
      _message(MessageModel.error(
        title: err.error,
        message: err.message,
      ));
    } else if (err is FailureApp) {
      _message(MessageModel.error(title: err.error, message: err.message));
    }
  }
}
