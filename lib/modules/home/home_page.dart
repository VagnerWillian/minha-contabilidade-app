import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/core.dart';
import 'components/components.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = Get.find();

  @override
  void initState() {
    _controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
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
            Column(
              children: [
                const SizedBox(height: 18),
                Visibility(
                  visible: _controller.selectedFund.value != null &&
                      _controller.summaryTransactionsFromFund.isNotEmpty,
                  child: const TransactionsList(),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
