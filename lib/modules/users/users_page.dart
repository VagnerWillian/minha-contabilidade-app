import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/core.dart';
import 'components/componentes.dart';
import 'users_controller.dart';

class UsersPage extends StatelessWidget {
  UsersPage({super.key});
  final _controller = Get.find<UsersController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeAdapter(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Gestão de Usuarios',
          style: ThemeAdapter(context).displayMedium,
        ),
        iconTheme: IconThemeData(color: ThemeAdapter(context).primaryColor),
        bottom: PreferredSize(
          preferredSize: const Size(double.nan, 5),
          child: Obx(() {
            return Visibility(
              visible: _controller.loadingUsers.isTrue,
              child: const LinearProgressIndicator(),
            );
          }),
        ),
      ),
      backgroundColor: ThemeAdapter(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: RefreshIndicator(
          onRefresh: _controller.onInit,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CustomFeatureHeader(
                title: 'Usuarios',
                subtitle: 'Gerenciamento de usuarios',
                centerContent: false,
              ),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: _controller.users.length,
                    itemBuilder: (_, index) {
                      var user = _controller.users[index];
                      return UserTile(user: user);
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}