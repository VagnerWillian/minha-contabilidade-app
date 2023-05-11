import 'package:get/get.dart';

import 'login_module/login_module.dart';
import 'splash_module/splash_module.dart';

abstract class Module {
  abstract List<GetPage> routers;
}

class AppModules{
  static final List<GetPage<dynamic>> pages = [
    ...SplashModule().routers,
    ...LoginModule().routers,
  ];
}