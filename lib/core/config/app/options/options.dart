import '../../../core.dart';

class OptionsApp implements OptionsEntity {
  @override
  late final bool maintenanceOn;

  OptionsApp.fromJson(Map<String, dynamic> json, bool inMaintenance) {
    maintenanceOn = inMaintenance;
  }
}
