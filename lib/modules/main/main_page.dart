import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../controllers/auth_user_controller.dart';
import '../../core/core.dart';
import '../home/module.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final AuthUserController _authUserController = Get.find();
  final _drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _drawerController,
      menuBackgroundColor: AppColors.white,
      borderRadius: 24.0,
      showShadow: true,
      angle: 0.0,
      slideWidth: MediaQuery.of(context).size.width * 0.50,
      drawerShadowsBackgroundColor: AppColors.grey500,
      menuScreen: const Scaffold(backgroundColor: Colors.white),
      mainScreen: Scaffold(
        backgroundColor: ThemeAdapter(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeAdapter(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          leading: const Icon(Iconsax.menu, color: Colors.black),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.face, color: Colors.black),
            )
          ],
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'C O N T A B I L I D A D E',
                style: ThemeAdapter(context).bodyMedium.copyWith(
                      color: ThemeAdapter(context).accentColor,
                      fontSize: 10,
                    ),
              ),
              Text(
                'V A G N E R W I L L I A N',
                style: ThemeAdapter(context).headlineMedium.copyWith(
                      color: ThemeAdapter(context).customColors.black,
                      fontSize: 14,
                    ),
              ),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: HomeModule(),
        ),
      ),
    );
  }
}
