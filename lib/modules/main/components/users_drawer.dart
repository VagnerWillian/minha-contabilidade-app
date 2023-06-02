import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../core/core.dart';
import '../../home/home_controller.dart';
import 'components.dart';

class UsersDrawer extends StatefulWidget {
  const UsersDrawer({super.key});

  @override
  State<UsersDrawer> createState() => _UsersDrawerState();
}

class _UsersDrawerState extends State<UsersDrawer> {
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomFeatureHeader(title: 'Usuários'),
            const SizedBox(height: 100),
            Expanded(
              child: Visibility(
                visible: _homeController.users.isNotEmpty,
                replacement: ShimmersHome.shimmerUsers,
                child: Column(
                  children: _homeController.users.map((user) => Obx(() {
                    return ListTile(
                      onTap: () {
                        _homeController.selectedUser(user);
                        _homeController.getAllDataFromSelectedUser();
                        Get.back();
                      },
                      title: Text(
                        user.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: ThemeAdapter(context).displayMedium,
                      ),
                      subtitle: Text(
                        user.email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: ThemeAdapter(context).bodySmall.copyWith(fontSize: 12),
                      ),
                      leading: !user.isAdmin
                          ? null
                          : Icon(
                        LineAwesome.crown_solid,
                        color: ThemeAdapter(context).customColors.orange50,
                      ),
                      trailing: user.uid != _homeController.selectedUser.value!.uid ? null : IconButton(
                        onPressed: (){},
                        icon: Icon(
                          FontAwesome.circle_check,
                          color: ThemeAdapter(context).customColors.green,
                        ),
                      ),
                    );
                  }
                  ))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
