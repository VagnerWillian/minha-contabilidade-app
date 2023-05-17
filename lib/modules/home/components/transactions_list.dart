import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../home_controller.dart';
import 'components.dart';

class TransactionsList extends StatefulWidget {
  const TransactionsList({super.key});

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> with TickerProviderStateMixin {
  final HomeController _controller = Get.find();
  late TabController _tabController;

  @override
  void initState() {
    updateTabController();
    super.initState();
  }

  void updateTabController() {
    _tabController = TabController(
      length: _controller.summaryTransactionsFromFund.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      updateTabController();
      return Visibility(
        visible: _controller.loadingSummariesTransactions.isFalse,
        replacement: ShimmerProgress.summariesShimmer(context),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: TabBar(
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
                labelStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                tabs: _controller.summaryTransactionsFromFund
                    .map((tr) => Text(
                          '${tr.month.toMonth} '
                          '${tr.month == 1 || tr.month == 12 ? '• ${tr.year}' : ''}',
                        ))
                    .toList(),
              ),
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
        ),
      );
    });
  }
}
