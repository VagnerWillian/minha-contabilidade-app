import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../core/core.dart';
import '../users_controller.dart';

class FundFromUserTile extends StatefulWidget {
  final FundEntity fund;
  final UserEntity user;
  const FundFromUserTile(this.fund, this.user, {super.key});

  @override
  State<FundFromUserTile> createState() => _FundFromUserTileState();
}

class _FundFromUserTileState extends State<FundFromUserTile> {
  final _controller = Get.find<UsersController>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 25,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: widget.fund.color.convertToColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.fund.name,
                    style: ThemeAdapter(context).displayMedium,
                  ),
                  Text(
                    widget.fund.isCredit?'Crédito':'Débito',
                    style: ThemeAdapter(context).bodySmall,
                  )
                ],
              ),
            ],
          ),
          Visibility(
            visible: !loading,
            replacement: Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.all(13),
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: ThemeAdapter(context).customColors.grey500,
              ),
            ),
            child: Visibility(
              visible: !widget.user.isAdmin,
              child: Visibility(
                visible: widget.user.cards.contains(widget.fund.id),
                replacement: IconButton(
                  onPressed: _addFundToUser,
                  icon: Icon(
                    FontAwesome.circle,
                    color: ThemeAdapter(context).customColors.grey500,
                  ),
                ),
                child: IconButton(
                  onPressed: _removeFundToUser,
                  icon: Icon(
                    FontAwesome.circle_check,
                    color: ThemeAdapter(context).customColors.green,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _addFundToUser() async {
    setState(() => loading = true);
    widget.user.cards.add(widget.fund.id);
    bool success = await _controller.updateFundsFromUser(widget.user, widget.user.cards);
    if(!success) widget.user.cards.remove(widget.fund.id);
    setState(() => loading = false);
  }

  Future<void> _removeFundToUser() async {
    setState(() => loading = true);
    widget.user.cards.remove(widget.fund.id);
    bool success = await _controller.updateFundsFromUser(widget.user, widget.user.cards);
    if(!success) widget.user.cards.add(widget.fund.id);
    setState(() => loading = false);
  }
}
