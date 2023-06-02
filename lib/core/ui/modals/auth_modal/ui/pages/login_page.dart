import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../core.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthModalController _controller = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) => Obx(
        () => AnimatedCrossFade(
          crossFadeState:
              _controller.loading.value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
          secondChild: _buildLoading(),
          firstChild: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Visibility(
              visible: !_controller.loading.value,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            BackButton(
                              onPressed: () => Get.back(),
                              color: ThemeAdapter(context).primaryColor,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Seja bem-vindo',
                                  style: ThemeAdapter(context).displayLarge,
                                ),
                                Text(
                                  _controller.loginWithBiometric.value.isEmpty
                                      ? 'Preencha os campos para entrar'
                                      : 'Escolha como deseja entrar',
                                  style: ThemeAdapter(context).bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Visibility(
                          visible: _controller.loginWithBiometric.value.isEmpty,
                          child: _buildFormFields(),
                        ),
                        const SizedBox(height: 18),
                      ],
                    ),
                    Visibility(
                      visible: _controller.loginWithBiometric.value.isEmpty,
                      replacement: _buildBiometricsLogin(),
                      child: _buildFormLoginButtons(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Form _buildFormFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            hint: 'Telefone ou Email',
            textInputType: TextInputType.emailAddress,
            controller: _controller.emailOrPhoneTextController,
            validator: (v) => Validators.validateEmail(v),
            onChanged: _controller.emailOrPhoneField,
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 85,
            child: Stack(
              children: [
                CustomTextField(
                  hint: 'Senha',
                  textInputType: TextInputType.text,
                  controller: _controller.passOrPhoneTextController,
                  validator: (v) => Validators.validatePassword(v),
                  onChanged: _controller.password,
                  obscureText: true,
                  backgroundColor: Colors.transparent,
                  showObscureText: _controller.showObscurePass.isTrue,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomCheckBox(
                    label: 'Lembrar dados',
                    value: _controller.rememberDataFields.value,
                    onChanged: _controller.rememberDataFields,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Column _buildBiometricsLogin() {
    return Column(
      children: [
        Visibility(
          visible: !_controller.isIos,
          replacement: Image.asset(
            'assets/images/face_id.png',
            color: ThemeAdapter(context).primaryColor,
            width: 130,
          ),
          child: Icon(
            FontAwesome.fingerprint,
            size: 130,
            color: ThemeAdapter(context).primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _controller.loginWithBiometric.value,
          textAlign: TextAlign.center,
          style: ThemeAdapter(context).bodySmall,
        ),
        const SizedBox(height: 12),
        CustomRectangleButton(
          size: const Size(double.infinity, 60),
          background: ThemeAdapter(context).primaryColor,
          label: 'Entrar com ${_controller.isIos ? 'Face ID' : 'Biometria'}',
          onPressed: _controller.authenticateWithBiometrics,
          labelStyle: ThemeAdapter(context).bodyMedium.copyWith(
                color: ThemeAdapter(context).customColors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        CustomRectangleButton(
          size: const Size(double.infinity, 60),
          background: ThemeAdapter(context).primaryColor.withOpacity(0.1),
          labelStyle: ThemeAdapter(context).displayMedium,
          label: 'Entrar com e-mail e senha',
          splash: ThemeAdapter(context).primaryColor,
          onPressed: () => _controller.loginWithBiometric(''),
        ),
      ],
    );
  }

  Column _buildFormLoginButtons() {
    return Column(
      children: [
        CustomRectangleButton(
          size: const Size(double.infinity, 60),
          background: Colors.transparent,
          label: 'Esqueci minha senha',
          labelStyle: ThemeAdapter(context).displayMedium,
          splash: ThemeAdapter(context).primaryColor,
          onPressed: () {},
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                child: CustomRectangleButton(
                  size: const Size(double.infinity, 60),
                  background: ThemeAdapter(context).primaryColor,
                  label: 'Entrar',
                  onPressed: login,
                  labelStyle: ThemeAdapter(context).bodyMedium.copyWith(
                        color: ThemeAdapter(context).customColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            Expanded(
              child: CustomRectangleButton(
                size: const Size(double.infinity, 60),
                background: ThemeAdapter(context).primaryColor.withOpacity(0.1),
                labelStyle: ThemeAdapter(context).displayMedium,
                label: 'Criar conta',
                splash: ThemeAdapter(context).primaryColor,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Entrando...',
          textAlign: TextAlign.center,
          style: ThemeAdapter(context).titleMedium.copyWith(
                color: ThemeAdapter(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          _controller.emailOrPhoneField.value,
          textAlign: TextAlign.center,
          style: ThemeAdapter(context).bodyMedium,
        ),
        const SizedBox(height: 24),
        const Center(
          child: CustomCircleProgress(),
        ),
      ],
    );
  }

  void login() {
    if (_formKey.currentState!.validate()) _controller.login();
  }
}
