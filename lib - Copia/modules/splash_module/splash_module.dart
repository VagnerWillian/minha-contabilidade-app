import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../utils/constants.dart';
import '../app_modules.dart';
import 'splash_page.dart';

class SplashModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: AppConstants.splashModuleRoute,
      page: () => const SplashPage(),
    )
  ];
}
