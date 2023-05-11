import 'package:get/get.dart';

import '../../core/core.dart';
import 'bindings.dart';
import 'ui/splash_page.dart';

class SplashModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: AppRoutes.splashRoute,
      page: () => const SplashPage(),
      binding: SplashBinding()
    ),
  ];
}
