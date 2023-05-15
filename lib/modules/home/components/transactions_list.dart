import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../core/domain/entities/entities.dart';

class TransactionsList extends StatefulWidget {
  final List<SummaryTransactionEntity> summariesTransactions;
  const TransactionsList(this.summariesTransactions, {super.key});

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: widget.summariesTransactions.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          controller: _tabController,
          padding: EdgeInsets.zero,
          indicatorPadding: EdgeInsets.zero,
          isScrollable: true,
          unselectedLabelColor: ThemeAdapter(context).primaryColor.withOpacity(0.5),
          unselectedLabelStyle: ThemeAdapter(context).bodySmall,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          indicator: const BubbleTabIndicator(
            padding: EdgeInsets.zero,
            indicatorHeight: 25.0,
            indicatorColor: Colors.transparent,
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          labelColor: ThemeAdapter(context).primaryColor,
          labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          tabs: widget.summariesTransactions
              .map((tr) => Text('${tr.month.toMonth} • ${tr.year}'))
              .toList(),
        ),
        const SizedBox(height: 18),
        DecoratedBox(
          decoration: BoxDecoration(
            color: ThemeAdapter(context).customColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Mochila',
                  style: ThemeAdapter(context).bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ThemeAdapter(context).customColors.black,
                  ),
                ),
                Text(
                  '02 de Maio de 2022',
                  style: ThemeAdapter(context).bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ThemeAdapter(context).customColors.grey400),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
