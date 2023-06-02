import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../core/core.dart';
import 'bindings.dart';
import 'users_page.dart';

class UsersModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: AppRoutes.usersRoute,
      page: () => UsersPage(),
      binding: UsersBindings()
    )
  ];
}
