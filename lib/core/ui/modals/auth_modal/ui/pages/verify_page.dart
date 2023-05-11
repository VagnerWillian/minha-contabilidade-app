import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../../../../core.dart';

class VerifyPage extends StatefulWidget {
  final PageController? pageController;
  const VerifyPage({super.key, this.pageController});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final AuthModalController _controller = Get.find();
  bool loading = false;
  bool resend = false;
  String? error;

  Future<void> sendEmail(bool value) async {
    setState(() => loading = true);
    error = await _controller.sendEmailVerification();
    setState(() {
      loading = false;
      resend = value;
    });
  }

  @override
  void didUpdateWidget(covariant VerifyPage oldWidget) {
    resend = false;
    error = null;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => Visibility(
        visible: _controller.step.value == AuthStep.verify,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Confirmar e-mail',
                    style: ThemeAdapter(context).titleMedium,
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(style: ThemeAdapter(context).bodySmall, children: <TextSpan>[
                      const TextSpan(
                          text: 'Enviamos um link de confirmação no '
                              'endereço de email '),
                      TextSpan(
                        style: ThemeAdapter(context).bodySmall,
                        text: _controller.emailOrPhoneField.value,
                      ),
                      const TextSpan(
                        text: '. Por favor, aguarde alguns minutos e, '
                            'caso não encontre na caixa de entrada, '
                            'verifique o lixo eletrônico ou spam.',
                      )
                    ]),
                  ),
                ],
              ),
              AnimatedCrossFade(
                crossFadeState: !resend ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 300),
                firstChild: Visibility(
                  visible: !loading,
                  replacement: const Center(
                    child: CustomCircleProgress(),
                  ),
                  child: Icon(
                    UniconsLine.envelope_shield,
                    size: 100,
                    color: ThemeAdapter(context).customColors.grey500,
                  ),
                ),
                secondChild: Icon(
                  error == null ? UniconsLine.envelope_redo : UniconsLine.envelope_times,
                  size: 100,
                  color: error == null
                      ? ThemeAdapter(context).accentColor
                      : ThemeAdapter(context).error,
                ),
              ),
              Column(
                children: [
                  Visibility(
                    visible: !resend,
                    replacement: SizedBox(
                      height: 40,
                      child: Text(
                        error ?? 'Reenviado!',
                        style: ThemeAdapter(context).bodyMedium,
                      ),
                    ),
                    child: Visibility(
                      visible: !loading,
                      child: CustomRectangleButton(
                        size: const Size(double.infinity, 60),
                        background: ThemeAdapter(context).primaryColor,
                        label: 'Reenviar link',
                        labelStyle: ThemeAdapter(context).bodyMedium.copyWith(
                            color: ThemeAdapter(context).customColors.white,
                            fontWeight: FontWeight.bold),
                        onPressed: () => sendEmail(true),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Visibility(
                    visible: !loading,
                    child: CustomRectangleButton(
                      size: const Size(double.infinity, 60),
                      background: ThemeAdapter(context).primaryColor.withOpacity(0.1),
                      label: 'Voltar',
                      labelStyle: ThemeAdapter(context).displayMedium,
                      onPressed: () {
                        _controller.loading(false);
                        _controller.step(AuthStep.login);
                        _controller.signOut();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
