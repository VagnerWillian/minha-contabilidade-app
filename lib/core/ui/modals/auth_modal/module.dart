import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core.dart';
import 'bindings.dart';

class AuthModalModule extends WidgetModule {
  const AuthModalModule({super.key});

  @override
  Widget get view => const AuthModalDialog();

  @override
  Bindings get bindings => AuthModalBindings();

}
