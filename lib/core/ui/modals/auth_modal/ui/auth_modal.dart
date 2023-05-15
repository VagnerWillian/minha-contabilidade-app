import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core.dart';
import '../module.dart';
import 'pages/biometrics_page.dart';
import 'pages/login_page.dart';
import 'pages/verify_page.dart';

class AuthModal {
  static Future<void> show() async {
    if (Get.context!.mounted) {
      if (!kIsWeb) {
        CustomBottomSheet.customContentBottomSheetModule(
          enableDrag: false,
          context: Get.context!,
          module: const AuthModalModule(),
        );
      } else {
        CustomDialog.show(
          isDismissible: false,
          content: const AuthModalModule(),
          borderRadius: 10,
        );
      }
    }
  }
}

class AuthModalDialog extends StatefulWidget {
  const AuthModalDialog({super.key});

  @override
  State<AuthModalDialog> createState() => _AuthModalState();
}

class _AuthModalState extends State<AuthModalDialog> {
  final AuthModalController _controller = Get.find();
  final PageController _pageController = PageController();

  Future<void> _stepListen(AuthStep step) async {
    if (_pageController.hasClients) {
      await _pageController.animateToPage(
        step.index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void initState() {
    _controller.step.listen(_stepListen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_controller.loading.value) {
          return false;
        } else if (_controller.step.value != AuthStep.login) {
          _controller.step(AuthStep.login);
          return false;
        }
        return true;
      },
      child: SizedBox(
        height: 400,
        width: kIsWeb ? 300 : Get.width,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: const [
            LoginPage(),
            VerifyPage(),
            BiometryPage(),
          ],
        ),
      ),
    );
  }
}
