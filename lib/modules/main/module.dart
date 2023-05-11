import 'package:get/get.dart';

import '../../core/core.dart';
import 'main_page.dart';

class MainModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: AppRoutes.mainRoute,
      page: () => const MainPage(),
    ),
  ];
}
