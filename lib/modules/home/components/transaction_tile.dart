import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../core/domain/entities/entities.dart';

class TransactionTile extends StatelessWidget {
  final TransactionEntity transaction;
  const TransactionTile(this.transaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: ThemeAdapter(context).customColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              transaction.description,
              style: ThemeAdapter(context).bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: ThemeAdapter(context).customColors.black,
              ),
            ),
            Text(
              DateTime.parse(transaction.date)
                  .format(AppConstants.fullDateWithHourPattern),
              style: ThemeAdapter(context).bodySmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ThemeAdapter(context).customColors.grey400),
            ),
          ],
        ),
      ),
    );
  }
}
