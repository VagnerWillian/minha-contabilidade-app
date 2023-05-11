import 'package:flutter/foundation.dart';

import '../../core.dart';

class MockRemoteConfig implements RemoteConfigAdapter {

  @override
  Future<void> init() async {  }

  @override
  Future<void> fetchData() async {
    if (kDebugMode) {
      print('[CARREGANDO REMOTE CONFIG MOCKADO...]');
    }
  }

  @override
  Future<dynamic> getDataFromKey({required String key}) async {
    return {}[key];
  }

  @override
  Future<bool> getBoolFromKey({required String key}) async{
    return false;
  }

}
