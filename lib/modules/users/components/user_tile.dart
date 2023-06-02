import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../core/core.dart';
import '../../home/components/components.dart';
import '../users_controller.dart';
import 'componentes.dart';

class UserTile extends StatefulWidget {
  final UserEntity user;
  const UserTile({required this.user, super.key});

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  final _controller = Get.find<UsersController>();
  bool loading = false;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        '${widget.user.name}${!widget.user.active ? '(Desativado)' : ''}',
        style: ThemeAdapter(context).displayMedium.copyWith(
              color: !widget.user.active
                  ? ThemeAdapter(context).customColors.grey500
                  : ThemeAdapter(context).accentColor,
            ),
      ),
      subtitle: Text(
        widget.user.email,
        style: ThemeAdapter(context).bodySmall,
      ),
      leading: !widget.user.isAdmin
          ? null
          : Icon(
              LineAwesome.crown_solid,
              color: ThemeAdapter(context).customColors.orange50,
            ),
      onExpansionChanged: (v) => setState(() => isExpanded = v),
      trailing: !isExpanded && widget.user.active
          ? null
          : Visibility(
              visible: !loading,
              replacement: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: ThemeAdapter(context).customColors.grey500,
                ),
              ),
              child: Visibility(
                visible: !widget.user.isAdmin,
                child: Visibility(
                  visible: widget.user.active,
                  replacement: _buildEnableButton(context, true),
                  child: _buildEnableButton(context, false),
                ),
              ),
            ),
      children: [
        Visibility(
          visible: widget.user.active,
          replacement: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Usuário desativado, ative-o para modifica-lo',
              style: ThemeAdapter(context).bodySmall,
            ),
          ),
          child: Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Fundos ativos',
                    style: ThemeAdapter(context).displayMedium,
                  ),
                  const SizedBox(height: 15),
                  Column(
                      children: _controller.funds
                          .map((fund) => FundFromUserTile(fund, widget.user))
                          .toList())
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  CustomRectangleButton _buildEnableButton(BuildContext context, bool active) {
    return CustomRectangleButton(
      size: const Size(80, 30),
      borderRadius: 100,
      background: active
          ? ThemeAdapter(context).customColors.green
          : ThemeAdapter(context).customColors.red,
      labelStyle: ThemeAdapter(context).bodySmall.copyWith(
            color: ThemeAdapter(context).customColors.white,
          ),
      label: active ? 'Ativar' : 'Desat.',
      onPressed: () => _active(active),
    );
  }

  Future<void> _active(bool active) async {
    setState(() => loading = true);
    bool confirm = await CustomQuestionModal.show(
      title: 'Tem certeza?',
      subtitle: 'Tem certeza que deseja '
          '${active ? 'ativar' : 'desativar'}'
          ' este usuário',
    );
    if (confirm) {
      await _controller.activeUser(widget.user, active);
    }
    setState(() => loading = false);
  }
}
