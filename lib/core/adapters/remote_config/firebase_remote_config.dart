import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart' as firebase;
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

import '../../core.dart';

class FirebaseRemoteConfig implements RemoteConfigAdapter {
  late final firebase.FirebaseRemoteConfig _remoteConfig;

  FirebaseRemoteConfig() {
    _remoteConfig = firebase.FirebaseRemoteConfig.instance;
    init();
  }

  @override
  Future<void> init() async {
    await Future.wait(
      [
        _remoteConfig.ensureInitialized(),
        _remoteConfig.setConfigSettings(
          RemoteConfigSettings(
            fetchTimeout: const Duration(minutes: 1),
            minimumFetchInterval: const Duration(seconds: kDebugMode ? 1 : 3600),
          ),
        ),
        fetchData()
      ],
    );
  }

  @override
  Future<void> fetchData() async {
    await _remoteConfig.fetch();
    await _remoteConfig.activate();
  }

  @override
  Future<dynamic> getDataFromKey({required String key}) async {
    String result;
    result = _remoteConfig.getString(key);
    var jsonDecoded = json.decode(result);
    return jsonDecoded;
  }

  @override
  Future<bool> getBoolFromKey({required String key}) async {
    return _remoteConfig.getBool(key);
  }
}
