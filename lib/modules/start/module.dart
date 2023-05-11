import 'package:get/get.dart';

import '../../core/core.dart';
import 'bindings.dart';
import 'ui/start_page.dart';

class StartModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: AppRoutes.startRoute,
      transition: Transition.fadeIn,
      page: () => const StartPage(),
      binding: StartBindings(),
    )
  ];
}