
import 'package:get/get.dart';

import '../../core/core.dart';
import 'funds_bindings.dart';
import 'funds_page.dart';

class FundsModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: AppRoutes.fundsRoute,
      page: () => FundsPage(),
      binding: FundsBindings()
    )
  ];
}
