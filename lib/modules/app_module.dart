import 'package:get/get.dart';

import 'funds/funds_module.dart';
import 'main/module.dart';
import 'signup/module.dart';
import 'splash/module.dart';
import 'start/module.dart';
import 'users/module.dart';

class AppModules{
  static final List<GetPage<dynamic>> pages = [
  ...MainModule().routers,
  ...SplashModule().routers,
  ...StartModule().routers,
  ...FundsModule().routers,
  ...SignUpModule().routers,
  ...UsersModule().routers,
  ];
}