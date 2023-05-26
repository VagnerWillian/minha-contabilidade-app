import 'package:flutter/material.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../core/core.dart';
import 'home_bindings.dart';
import 'home_page.dart';

class HomeModule extends WidgetModule {
  const HomeModule({super.key});

  @override
  Bindings? get bindings => HomeBindings();

  @override
  Widget get view => const HomePage();

}
