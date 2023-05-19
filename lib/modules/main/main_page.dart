import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../core/core.dart';
import '../home/module.dart';
import 'components/components.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final _drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _drawerController,
      menuBackgroundColor: AppColors.white,
      borderRadius: 24.0,
      showShadow: true,
      androidCloseOnBackTap: true,
      mainScreenTapClose: true,
      angle: 0.0,
      slideWidth: MediaQuery.of(context).size.width * 0.70,
      drawerShadowsBackgroundColor: AppColors.grey500,
      menuScreen: const MenuScreen(),
      mainScreen: Scaffold(
        backgroundColor: ThemeAdapter(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeAdapter(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: ()=>_drawerController.open!(),
            icon: const Icon(Iconsax.menu, color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.face, color: Colors.black),
            )
          ],
          title: const BusinessLogo(),
        ),
        body: const HomeModule(),
      ),
    );
  }
}
