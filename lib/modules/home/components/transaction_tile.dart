import 'package:cloud_firestore/cloud_firestore.dart';
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
  bool _deleteLoading = false;
  bool _approveLoading = false;
  bool _postponeLoading = false;

  late bool _isApproved;
  late bool _isPostpone;

  final HomeController _controller = Get.find();

  @override
  void initState() {
    _isApproved = widget.transaction.approvedDate != null;
    _isPostpone = widget.transaction.postponeDate != null;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TransactionTile oldWidget) {
    _isApproved = widget.transaction.approvedDate != null;
    _isPostpone = widget.transaction.postponeDate != null;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Dismissible(
        key: Key(widget.transaction.id),
        direction: _defineDirection(),
        confirmDismiss: _confirmDismiss,
        secondaryBackground: _buildDeleteBg(context),
        background: _buildBg(context),
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        _isPostpone
                            ? 'ADIADO'
                            : !_isApproved
                                ? 'PENDENTE'
                                : '${widget.transaction.isPurchase ? '+' : '-'} '
                                    '${widget.transaction.price.toRealFormat()}',
                        style: ThemeAdapter(context).bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: _isPostpone
                                  ? ThemeAdapter(context).customColors.grey500
                                  : !_isApproved
                                      ? ThemeAdapter(context).customColors.grey500
                                      : widget.transaction.isPurchase
                                          ? ThemeAdapter(context).customColors.red
                                          : ThemeAdapter(context).customColors.successColor,
                            ),
                      ),
                      Visibility(
                        visible: _isPostpone || !_isApproved,
                        replacement: Text(
                          'aprovado',
                          style: ThemeAdapter(context).bodySmall.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ThemeAdapter(context).customColors.blue100),
                        ),
                        child: Text(
                          '${!_isPostpone && widget.transaction.isPurchase ? '+' : '-'} '
                          '${widget.transaction.price.toRealFormat()}',
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

  Widget _buildBg(BuildContext context) {
    return Visibility(
      visible: !_isApproved,
      replacement: DecoratedBox(
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
                    LineAwesome.arrow_right_solid,
                    color: Colors.white,
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _postponeLoading ? 'ADIANDO...' : 'ADIAR',
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
              visible: _postponeLoading,
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
      child: DecoratedBox(
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
                        _approveLoading ? 'APROVANDO...' : 'APROVAR',
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
              visible: _approveLoading,
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
    );
  }

  DecoratedBox _buildDeleteBg(BuildContext context) {
    return DecoratedBox(
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
                      _deleteLoading ? 'APAGANDO...' : 'APAGAR',
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
            visible: _deleteLoading,
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
    );
  }

  Future<bool?> _confirmDismiss(dir) async {
    bool confirm = await _confirmProcess(
      dir == DismissDirection.endToStart
          ? 'EXCLUIR'
          : dir == DismissDirection.startToEnd && !_isApproved
              ? 'APROVAR'
              : 'ADIAR',
    );
    if (!confirm) return confirm;
    if (dir == DismissDirection.endToStart) return await _deleteTransaction();
    if (widget.transaction.approvedDate != null) return await _postponeTransaction();
    return await _approveTransaction();
  }

  DismissDirection _defineDirection() {
    return widget.transaction.failure != null
        ? DismissDirection.none
        : _controller.authUserController.userLogged!.isAdmin &&
                (!_isApproved ||
                    (!_isPostpone && _controller.summariesFromFund.length > _controller.page + 1))
            ? DismissDirection.horizontal
            : widget.transaction.approvedDate == null ||
                    _controller.authUserController.userLogged!.isAdmin
                ? DismissDirection.endToStart
                : DismissDirection.none;
  }

  Future<bool> _deleteTransaction() async {
    bool success = false;
    setState(() => _deleteLoading = true);
    success = await _controller.deleteTransaction(widget.transaction);
    if (!success) setState(() => _deleteLoading = false);
    return success;
  }

  Future<bool> _approveTransaction() async {
    setState(() => _approveLoading = true);
    widget.transaction.approvedDate = Timestamp.fromDate(AppConstants().todayNow);
    await _controller.updateTransaction(widget.transaction);
    setState(() {
      _isApproved = true;
      _approveLoading = false;
    });
    return false;
  }

  Future<bool> _postponeTransaction() async {
    setState(() => _postponeLoading = true);
    widget.transaction.postponeDate = Timestamp.fromDate(AppConstants().todayNow);
    await _controller.postponeTransaction(widget.transaction);
    setState(() {
      _isPostpone = true;
      _postponeLoading = false;
    });
    return false;
  }

  Future<bool> _confirmProcess(String action) async {
    return await CustomQuestionModal.show(
      title: 'Tem certeza?',
      subtitle: 'Tem certeza que deseja $action'
          ' a transação ${widget.transaction.description.toUpperCase()}.',
    );
  }
}
