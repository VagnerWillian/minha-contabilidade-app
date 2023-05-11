import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isShowLogo = false;
  bool showTexts = false;
  late final SplashController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find();
    _controller.init();
    showLogo();
  }

  Future<void> showLogo() async {
    setState(() => isShowLogo = true);
    setState(() => showTexts = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 100),
              child: const Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 1,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
