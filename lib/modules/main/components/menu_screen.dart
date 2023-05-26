import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../controllers/auth_user_controller.dart';
import '../../../core/core.dart';
import '../../home/home_controller.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildItemMenu(IconData icon, String title, {VoidCallback? onTap, Color? color}) =>
        ListTile(
          onTap: onTap,
          leading: Icon(
            icon,
            color: color ?? ThemeAdapter(context).accentColor,
          ),
          title: Text(
            title,
            style: ThemeAdapter(context).displayMedium.copyWith(
                  color: color ?? ThemeAdapter(context).accentColor,
                ),
          ),
        );

    return Column(
      children: [
        const Expanded(child: SizedBox.shrink()),
        Expanded(
            flex: 4,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                buildItemMenu(
                  LineAwesome.credit_card,
                  'Fundos',
                  onTap: ()async {
                    await Get.toNamed(AppRoutes.fundsRoute);
                    Get.find<HomeController>().onInit();
                  },
                ),
                buildItemMenu(LineAwesome.users_solid, 'Usuarios'),
                buildItemMenu(LineAwesome.youtube, 'Assinaturas'),
                const Spacer(),
                buildItemMenu(
                  LineAwesome.sign_out_alt_solid,
                  'Recarregar cards',
                  color: ThemeAdapter(context).error,
                  onTap: ()=>Get.find<HomeController>().onInit()
                ),
                buildItemMenu(
                  LineAwesome.sign_out_alt_solid,
                  'Sair',
                  color: ThemeAdapter(context).error,
                  onTap: ()=>Get.find<AuthUserController>().signOut()
                ),
              ],
            )),
        const Expanded(child: SizedBox.shrink()),
      ],
    );
  }
}
