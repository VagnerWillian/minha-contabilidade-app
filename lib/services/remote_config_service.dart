import 'package:get/get.dart';

import '../core/core.dart';

class RemoteConfigService extends GetxService implements RemoteConfigServiceInterface {
  final RemoteConfigAdapter _remoteConfigAdapter;
  RemoteConfigService(this._remoteConfigAdapter);

  @override
  late final OptionsEntity options;

  @override
  Future<void> init() async {
    try {
      await _remoteConfigAdapter.init();
      await getOptions();
    } on Exception catch (e, stack) {
      throw FailureRemoteConfig(exception: e, stack: stack);
    }
  }

  @override
  Future<void> getOptions() async{
    var inMaintenance = await _remoteConfigAdapter.getBoolFromKey(
      key: FirebaseConstants.optionsKey,
    );
    options = OptionsApp.fromJson({}, inMaintenance);
  }
}
