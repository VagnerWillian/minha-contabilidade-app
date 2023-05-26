import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../controllers/controllers.dart';
import '../../../core/core.dart';
import '../core/domain/entities/entities.dart';
import '../home_controller.dart';
import 'components.dart';

class TransactionTile extends StatefulWidget {
  final TransactionEntity transaction;
  const TransactionTile(this.transaction, {super.key});

  @override
  State<TransactionTile> createState() => _TransactionTileState();
}

class _TransactionTileState extends State<TransactionTile> {
  bool deleteLoading = false;
  bool updateLoading = false;
  final HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Dismissible(
        key: Key(widget.transaction.id),
        direction: _defineDirection(),
        confirmDismiss: _confirmDismiss,
        secondaryBackground: DecoratedBox(
          decoration: BoxDecoration(
            color: ThemeAdapter(context).error,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          deleteLoading ? 'APAGANDO...' : 'APAGAR',
                          style: ThemeAdapter(context).bodySmall.copyWith(
                                fontWeight: FontWeight.bold,
                                color: ThemeAdapter(context).customColors.white,
                              ),
                        ),
                        Text(
                          widget.transaction.description,
                          style: ThemeAdapter(context).bodySmall.copyWith(
                                color: ThemeAdapter(context).customColors.white,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Icon(
                      LineAwesome.trash_alt,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: deleteLoading,
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
        ),
        background: DecoratedBox(
          decoration: BoxDecoration(
            color: ThemeAdapter(context).customColors.blue100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Icon(
                      LineAwesome.check_double_solid,
                      color: Colors.white,
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          updateLoading ? 'APROVANDO...' : 'APROVAR',
                          style: ThemeAdapter(context).bodySmall.copyWith(
                                fontWeight: FontWeight.bold,
                                color: ThemeAdapter(context).customColors.white,
                              ),
                        ),
                        Text(
                          widget.transaction.description,
                          style: ThemeAdapter(context).bodySmall.copyWith(
                                color: ThemeAdapter(context).customColors.white,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              Visibility(
                visible: updateLoading,
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
        ),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: ThemeAdapter(context).customColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.transaction.description,
                        style: ThemeAdapter(context).bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ThemeAdapter(context).customColors.black,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        DateTime.parse(widget.transaction.date)
                            .format(AppConstants.fullDateWithHourPattern),
                        style: ThemeAdapter(context).bodySmall.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ThemeAdapter(context).customColors.grey400),
                      ),
                      Visibility(
                        visible: Get.find<AuthUserController>().userLogged!.isAdmin &&
                            widget.transaction.failure == null,
                        child: Text(
                          widget.transaction.userName.toUpperCase(),
                          style: ThemeAdapter(context).bodySmall.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: ThemeAdapter(context).accentColor),
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: widget.transaction.failure == null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.transaction.approvedDate.isEmpty
                            ? 'PENDENTE'
                            : '${widget.transaction.isPurchase ? '+' : '-'} ${widget.transaction.price.toRealFormat()}',
                        style: ThemeAdapter(context).bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: widget.transaction.approvedDate.isEmpty
                                  ? ThemeAdapter(context).customColors.grey500
                                  : widget.transaction.isPurchase
                                      ? ThemeAdapter(context).customColors.red
                                      : ThemeAdapter(context).customColors.successColor,
                            ),
                      ),
                      Visibility(
                        visible: widget.transaction.approvedDate.isEmpty,
                        replacement: Text(
                          'aprovado',
                          style: ThemeAdapter(context).bodySmall.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ThemeAdapter(context).customColors.blue100),
                        ),
                        child: Text(
                          '${widget.transaction.isPurchase ? '+' : '-'} ${widget.transaction.price.toRealFormat()}',
                          style: ThemeAdapter(context).bodySmall.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ThemeAdapter(context).customColors.grey500),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> _confirmDismiss(dir) async {
    bool confirm = await _confirmProcess(
      dir == DismissDirection.endToStart,
    );
    if (!confirm) return confirm;
    if (dir == DismissDirection.endToStart) return await _deleteTransaction();
    return await _updateTransaction();
  }

  DismissDirection _defineDirection() {
    return widget.transaction.failure != null
        ? DismissDirection.none
        : widget.transaction.approvedDate.isEmpty &&
                _controller.authUserController.userLogged!.isAdmin
            ? DismissDirection.horizontal
            : widget.transaction.approvedDate.isNotEmpty &&
                    _controller.authUserController.userLogged!.isAdmin
                ? DismissDirection.endToStart
                : DismissDirection.none;
  }

  Future<bool> _deleteTransaction() async {
    bool success = false;
    setState(() => deleteLoading = true);
    success = await _controller.deleteTransaction(widget.transaction);
    if (!success) setState(() => deleteLoading = false);
    return success;
  }

  Future<bool> _updateTransaction() async {
    bool success = false;
    setState(() => updateLoading = true);
    widget.transaction.approvedDate = AppConstants().todayNow.toString();
    success = await _controller.updateTransaction(widget.transaction);
    if (!success) setState(() => updateLoading = false);
    return false;
  }

  Future<bool> _confirmProcess(bool exclude) async {
    return await CustomQuestionModal.show(
      title: 'Tem certeza?',
      subtitle: 'Tem certeza que deseja ${exclude ? 'EXCLUIR' : 'APROVAR'}'
          ' a transação ${widget.transaction.description.toUpperCase()}.',
    );
  }
}
