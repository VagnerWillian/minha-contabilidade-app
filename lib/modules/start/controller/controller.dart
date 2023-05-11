import 'package:get/get.dart';

import '../../../core/core.dart';

class StartController extends GetxController with MessagesMixin {

  // Variables
  final message = Rxn<MessageModel>();

  void _defineError(Failure err) {
    if (err is FailureNetwork) {
      message(MessageModel.network(
        title: err.error,
        message: err.message,
        failureNetwork: err,
      ));
    } else if (err is FailureApp) {
      message(MessageModel.error(
        title: err.error,
      ));
    }
  }
}
