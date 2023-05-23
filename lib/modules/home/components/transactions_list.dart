import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

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

  @override
  void initState() {
    updateTabController();
    super.initState();
  }

  void updateTabController() {
    _controller.tabController = TabController(
      length: _controller.summariesFromFund.length,
      initialIndex: _controller.initialIndex,
      vsync: this,
    )..addListener(_controller.handleTabChange);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      updateTabController();
      return Visibility(
        visible: _controller.summariesFromFund.isNotEmpty,
        replacement: Container(
          margin: const EdgeInsets.all(20),
          child: Text(
            AppConstants.listSummariesEmpty,
            textAlign: TextAlign.center,
            style: ThemeAdapter(context).bodySmall,
          ),
        ),
        child: Visibility(
          visible: _controller.loadingSummariesTransactions.isFalse,
          replacement: ShimmerProgress.summariesShimmer(context),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        controller: _controller.tabController,
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
                        tabs: _controller.summariesFromFund
                            .map((tr) => Text(
                                  tr.failure != null
                                      ? 'ERRO!'
                                      : '${tr.month.toMonth} '
                                          '${tr.month == 1 || tr.month == 12 ? '• ${tr.year}' : ''}',
                                ))
                            .toList(),
                      ),
                    ),
                    Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: CustomRectangleButton(
                        label: 'Incluir Compra',
                        prefixIcon: const Icon(LineAwesome.shopping_bag_solid),
                        background: ThemeAdapter(context).customColors.green,
                        onPressed: _controller.loadingTransactions.isTrue ? null : () {},
                      ),
                    ),
                    Visibility(
                      visible: _controller.loadingTransactions.isFalse,
                      replacement: ShimmerProgress.transactionsShimmer(context),
                      child: Visibility(
                        visible: _controller.transactions.isNotEmpty,
                        replacement: Text(
                          AppConstants.listTransactionsEmpty,
                          textAlign: TextAlign.center,
                          style: ThemeAdapter(context).bodySmall,
                        ),
                        child: SizedBox(
                          height: _controller.transactions.length * 110,
                          child: TabBarView(
                            controller: _controller.tabController,
                            children: _controller.summariesFromFund.map((trs) {
                              return Column(
                                  children: _controller.transactions
                                      .map(
                                        (trs) => TransactionTile(trs),
                                      )
                                      .toList());
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
