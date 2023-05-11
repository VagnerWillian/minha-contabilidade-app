import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../../../core/core.dart';
import '../controller/controller.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late final StartController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/background.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'C O N T A B I L I D A D E',
                    style: ThemeAdapter(context).bodyMedium.copyWith(
                          color: ThemeAdapter(context).customColors.white,
                          fontSize: 14,
                        ),
                  ),
                  Text(
                    'VAGNER WILLIAN',
                    style: ThemeAdapter(context)
                        .headlineMedium
                        .copyWith(color: ThemeAdapter(context).accentColor),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Divider(
                              height: 20,
                            ),
                            Text(
                              'Para acessar os seus dados entre',
                              style: ThemeAdapter(context)
                                  .bodySmall
                                  .copyWith(color: ThemeAdapter(context).accentSecondaryColor),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 280,
                              height: 55,
                              child: CustomRectangleButton(
                                label: 'Entrar',
                                background: ThemeAdapter(context).accentColor,
                                labelStyle: ThemeAdapter(context).bodyMedium.copyWith(
                                    color: ThemeAdapter(context).customColors.white,
                                    fontWeight: FontWeight.bold),
                                onPressed: AuthModal.show,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Não possui uma conta? ',
                                style: ThemeAdapter(context)
                                    .bodySmall
                                    .copyWith(color: ThemeAdapter(context).accentSecondaryColor),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Cadastre-se',
                                    style: ThemeAdapter(context).bodySmall.copyWith(
                                        color: ThemeAdapter(context).accentColor,
                                        decoration: TextDecoration.underline),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
