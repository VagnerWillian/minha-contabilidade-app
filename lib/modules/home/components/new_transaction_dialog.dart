import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../core/infra/models/models.dart';
import '../home_controller.dart';

class NewTransactionDialog extends StatefulWidget {
  final bool isPurchase;
  const NewTransactionDialog({
    super.key,
    this.isPurchase = true,
  });

  @override
  State<NewTransactionDialog> createState() => _NewTransactionDialogState();
}

class _NewTransactionDialogState extends State<NewTransactionDialog> {
  bool loading = false;

  final HomeController _controller = Get.find();
  final _formKey = GlobalKey<FormState>();
  final _priceController = MoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
    leftSymbol: 'R\$ ',
  );
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomFeatureHeader(
              title: widget.isPurchase ? 'Adicionar compra' : 'Adicionar pagamento',
              subtitle: 'Preencha os campos',
            ),
            CustomTextField(
              hint: 'Descrição',
              controller: _descriptionController,
              textInputType: TextInputType.text,
              backgroundColor: Colors.transparent,
              validator: Validators.validateTextEmpty,
            ),
            CustomTextField(
              hint: 'Valor',
              textInputType: TextInputType.number,
              backgroundColor: Colors.transparent,
              controller: _priceController,
              validator: (str) => str == 'R\$ 0,00' ? 'Valor inválido' : null,
            ),
            const SizedBox(height: 18),
            Stack(
              children: [
                CustomRectangleButton(
                  size: const Size(double.nan, 60),
                  label: loading ? 'Carregando...' : 'Confirmar',
                  onPressed: loading ? null : create,
                ),
                Visibility(
                  visible: loading,
                  child: SizedBox(
                    height: 60,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.transparent,
                      color: ThemeAdapter(context).customColors.white!.withOpacity(0.3),
                    ),
                  ),
                )
              ],
            ),
            Visibility(
              visible: !loading,
              child: CustomRectangleButton(
                size: const Size(double.nan, 60),
                background: Colors.transparent,
                labelStyle: ThemeAdapter(context).displaySmall,
                label: 'Cancelar',
                onPressed: () => Get.back(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> create() async {
    var newTransaction = TransactionFund(
      idFund: _controller.selectedFund.value!.id,
      userName: _controller.authUserController.userLogged!.name,
      userId: _controller.authUserController.userLogged!.uid,
      isPurchase: widget.isPurchase,
      date: DateTime.now().toString(),
      price: _priceController.text.tryConvertRealToDouble(),
      description: _descriptionController.text,
      summaryId: _controller.summariesFromFund[_controller.page].id,
    );

    if (_formKey.currentState?.validate() ?? false) {
      setState(() => loading = true);
      await _controller.createTransaction(newTransaction);
      setState(() => loading = false);
      Get.back();
    }
  }
}
