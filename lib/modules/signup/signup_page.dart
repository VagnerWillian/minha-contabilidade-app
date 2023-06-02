import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../core/core.dart';
import 'signup_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final SignUpController _controller;
  late final MaskedTextController _cpfTextController;
  late final TextEditingController _nameTextController;
  late final TextEditingController _emailTextController;
  late final TextEditingController _passTextController;
  late final TextEditingController _confirmPassTextController;
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  bool created = false;

  @override
  void initState() {
    _controller = Get.find();
    _cpfTextController = MaskedTextController(mask: '000.000.000-00');
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passTextController = TextEditingController();
    _confirmPassTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeAdapter(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text('Novo usuario', style: ThemeAdapter(context).displayMedium),
        iconTheme: IconThemeData(color: ThemeAdapter(context).primaryColor),
      ),
      backgroundColor: ThemeAdapter(context).scaffoldBackgroundColor,
      body: Visibility(
        visible: !created,
        replacement: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LineAwesome.check_circle,
              size: 80,
              color: ThemeAdapter(context).primaryColor,
            ),
            const Text(
              'Conta criada com sucesso!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            Column(
              children: [
                CustomRectangleButton(
                  size: const Size(200, 60),
                  label: 'Entrar',
                  onPressed: () => Get.back(),
                ),
              ],
            )
          ],
        ),
        child: Visibility(
          visible: !loading,
          replacement: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    color: ThemeAdapter(context).primaryColor,
                    strokeWidth: 2,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Criando conta...só um momento...',
                textAlign: TextAlign.center,
                style: ThemeAdapter(context).bodySmall,
              ),
              Text(
                _emailTextController.text,
                textAlign: TextAlign.center,
                style: ThemeAdapter(context).displaySmall,
              )
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                CustomTextField(
                                  hint: 'Nome completo',
                                  textInputType: TextInputType.name,
                                  validator: Validators.validateName,
                                  textCapitalization: TextCapitalization.sentences,
                                  controller: _nameTextController,
                                ),
                                CustomTextField(
                                  hint: 'E-mail',
                                  textInputType: TextInputType.emailAddress,
                                  validator: (str) => Validators.validateEmail(str),
                                  controller: _emailTextController,
                                ),
                                CustomTextField(
                                  hint: 'CPF',
                                  textInputType: TextInputType.number,
                                  controller: _cpfTextController,
                                  validator: (str) => Validators.validateCPF(str),
                                ),
                                CustomTextField(
                                  hint: 'Senha',
                                  textInputType: TextInputType.text,
                                  obscureText: true,
                                  controller: _passTextController,
                                  validator: (str) => Validators.validateMinLength(str, 6),
                                ),
                                CustomTextField(
                                  hint: 'Confirmar senha',
                                  textInputType: TextInputType.text,
                                  obscureText: true,
                                  controller: _confirmPassTextController,
                                  validator: (str) => Validators.validateEqual(
                                    str,
                                    _passTextController.text,
                                    'Senhas não coincidem...',
                                  ),
                                ),
                              ],
                            ),
                            CustomRectangleButton(
                              label: 'Criar conta',
                              size: const Size(double.nan, 60),
                              onPressed: _createAccount,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }

  Future<void> _createAccount() async {
    bool success = false;
    setState(() => loading = true);
    if (_formKey.currentState!.validate()) {
      success = await _controller.createAccountWithEmailAndPass(
        _emailTextController.text,
        _confirmPassTextController.text,
        _nameTextController.text,
        _cpfTextController.text
      );
    }
    if(!success) setState(() => loading = false);
    setState(() => created = success);
  }
}
