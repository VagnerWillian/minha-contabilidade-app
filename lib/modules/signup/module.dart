import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../core/core.dart';
import 'signup_bindings.dart';
import 'signup_page.dart';

class SignUpModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: AppRoutes.signupRoute,
      page: () => const SignUpPage(),
      binding: SignUpBindings()
    )
  ];
}
