import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_user_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final AuthUserController _authUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contabilidade'),
      ),
      body: Center(
        child: InkWell(
          onTap: ()=>_authUserController.signOut(),
          child: const Text(
            'Hello Vagner',
          ),
        ),
      ),
    );
  }
}
