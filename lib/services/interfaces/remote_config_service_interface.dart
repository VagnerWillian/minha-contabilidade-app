import '../../core/core.dart';

abstract class RemoteConfigServiceInterface {
  late OptionsEntity options;
  Future<void> init();
  Future<void> getOptions();
}
