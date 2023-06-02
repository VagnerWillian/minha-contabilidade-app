import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/bindings/app_binding.dart';
import 'firebase_options.dart';
import 'modules/app_widget.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await AppBindings().dependencies();
  runApp(const AppWidget());
}