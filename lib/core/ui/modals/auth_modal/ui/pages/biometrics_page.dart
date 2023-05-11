import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../core.dart';

class BiometryPage extends StatefulWidget {
  const BiometryPage({super.key});

  @override
  State<BiometryPage> createState() => _BiometryPageState();
}

class _BiometryPageState extends State<BiometryPage> {
  late final AuthModalController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find();
  }

  @override
  Widget build(BuildContext context) => Visibility(
        visible: _controller.step.value == AuthStep.biometrics,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: ThemeAdapter(context).headlineMedium,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Entrar com ${_controller.isIos ? 'o' : 'a'} ',
                          ),
                          TextSpan(
                            style: ThemeAdapter(context).titleMedium,
                            text: _controller.isIos ? 'Face ID' : 'Biometria',
                          ),
                          const TextSpan(
                            text: '?',
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Da próxima vez que entrar, não precisará preencher nenhum campo,'
                      ' usaremos o identificador digital do seu dispositivo para autenticar.',
                      textAlign: TextAlign.center,
                      style: ThemeAdapter(context).bodyMedium,
                    ),
                    Visibility(
                      visible: !_controller.isIos,
                      replacement: Image.asset(
                        '',
                        width: 120,
                        color: ThemeAdapter(context).primaryColor,
                      ),
                      child: Icon(
                        FontAwesome.fingerprint,
                        size: 65,
                        color: ThemeAdapter(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomRectangleButton(
                      onPressed: () => _controller.completeLogin(useBiometry: true),
                      size: const Size(0, 60),
                      label: 'Sim',
                      labelStyle: ThemeAdapter(context).displayMedium.copyWith(
                        color: ThemeAdapter(context).customColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: CustomRectangleButton(
                      onPressed: () => _controller.completeLogin(useBiometry: false),
                      size: const Size(0, 60),
                      background: ThemeAdapter(context).primaryColor.withOpacity(0.1),
                      labelStyle: ThemeAdapter(context).displayMedium,
                      label: 'Não',
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
}
