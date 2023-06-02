import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:contabilidade_app/modules/home/core/domain/entities/transaction_entity.dart';
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
      var summary = _controller.summariesFromFund[_controller.page];

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
                                      : '${tr.month.name} '
                                          '${tr.month == 1 || tr.month == 12 ? '• ${tr.year}' : ''}',
                                ))
                            .toList(),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: ThemeAdapter(context).customColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('Resumo', style: ThemeAdapter(context).titleMedium),
                          Text('Total gasto no período de ${summary.month.name}:',
                              style: ThemeAdapter(context).bodySmall),
                          const SizedBox(height: 10),
                          Text(summary.totally.toRealFormat(),
                              style: ThemeAdapter(context).titleMedium),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 60,
                            child: CustomRectangleButton(
                              label: 'Incluir Compra',
                              prefixIcon: const Icon(LineAwesome.shopping_bag_solid),
                              background: ThemeAdapter(context).customColors.green,
                              onPressed: _permissionForAdd(summary) ? addTransaction : null,
                            ),
                          )
                        ],
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
                            children: _controller.summariesFromFund.map((smr) {
                              return ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _controller.transactions.length,
                                itemBuilder: (_, index) =>
                                    TransactionTile(_controller.transactions[index]),
                                separatorBuilder: (_, index) {
                                  if (_controller.transactions
                                          .where((trs) => trs.approvedDate == null)
                                          .length ==
                                      index + 1) {
                                    return _buildDivider();
                                  }
                                  return const SizedBox.shrink();
                                },
                              );
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

  bool _permissionForAdd(SummaryTransactionEntity summary) {
    return _controller.loadingTransactions.isFalse &&
        (AppConstants().todayNow.isBefore(summary.closeDate) &&
                _controller.selectedFund.value!.active ||
            _controller.authUserController.userLogged!.isAdmin);
  }

  Column _buildDivider() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 60,
            child: Divider(
              thickness: 3,
            )),
      ],
    );
  }

  Future<void> addTransaction() async => await CustomDialog.show(
        borderRadius: 10,
        content: const NewTransactionDialog(isPurchase: true),
      );
}
