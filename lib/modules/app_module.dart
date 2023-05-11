import 'package:get/get.dart';

import 'main/module.dart';
import 'splash/module.dart';
import 'start/module.dart';

class AppModules{
  static final List<GetPage<dynamic>> pages = [
  ...MainModule().routers,
  ...SplashModule().routers,
  ...StartModule().routers,
  ];
}