import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../utils/constants.dart';
import '../app_modules.dart';
import 'login_page.dart';

class LoginModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: AppConstants.loginModuleRoute,
      page: () => const LoginPage(),
    )
  ];
}
