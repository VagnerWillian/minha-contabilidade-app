import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/components.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    _controller.getAllFunds();
    return Obx(() {
      return Column(
        children: [
          CarouselSlider(
            items: [
              const MenuSummary(),
              ..._controller.funds.map((fund) => MenuCard(fund: fund)).toList()
            ],
            options: CarouselOptions(
              onPageChanged: (page, _) => _controller.changeCard(page),
              height: 400,
              viewportFraction: 0.70,
              initialPage: 0,
              autoPlay: false,
              enableInfiniteScroll: false,
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(height: 18),
          Visibility(
            visible: _controller.selectedFund.value != null &&
                _controller.loadingSummariesTransactions.isFalse,
            maintainState: true,
            child: TransactionsList(_controller.summaryTransactionsFromFund),
          )
        ],
      );
    });
  }
}
