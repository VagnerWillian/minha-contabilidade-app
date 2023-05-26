import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

import 'components/components.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = Get.find();
  final int maxAdaptiveScreenWidth = 900;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if ((kIsWeb && MediaQuery.of(context).size.width > maxAdaptiveScreenWidth) ||
          MediaQuery.of(context).size.width > maxAdaptiveScreenWidth) {
        return _buildPageFromWeb(context);
      }
      return _buildPageOthersPlatforms(context);
    });
  }

  Widget _buildPageOthersPlatforms(BuildContext context) {
    const itemWidth = 280.0;
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: _controller.loadingFunds.isFalse,
              replacement: ShimmerProgress.cardsShimmerH(context),
              child: CarouselSlider(
                items: [
                  MenuSummary(reloadData: _controller.onInit, width: itemWidth),
                  ..._controller.funds
                      .map(
                        (fund) => MenuCard(
                          fund: fund,
                          width: itemWidth,
                        ),
                      )
                      .toList(),
                ],
                options: CarouselOptions(
                  onPageChanged: (page, _) => _controller.changeCard(page),
                  height: 400,
                  initialPage: 0,
                  viewportFraction: itemWidth / MediaQuery.of(context).size.width,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  enlargeFactor: 0.3,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 18),
                Visibility(
                  visible: _controller.selectedFund.value != null &&
                      _controller.summariesFromFund.isNotEmpty,
                  child: const TransactionsList(),
                ),
              ],
            )
          ],
        ),
      );
    });
  }

  Widget _buildPageFromWeb(BuildContext context) {
    const itemWidth = 280.0;

    return Obx(() {
      return Row(
        children: [
          Visibility(
            visible: _controller.loadingFunds.isFalse,
            replacement: ShimmerProgress.cardsShimmerV(context),
            child: SizedBox(
              width: 500,
              child: StackedCardCarousel(
                pageController: _controller.pageController,
                onPageChanged: _controller.changeCard,
                type: StackedCardCarouselType.fadeOutStack,
                initialOffset: 5,
                spaceBetweenItems: 420,
                items: [
                  MenuSummary(
                    reloadData: _controller.onInit,
                    width: itemWidth,
                    height: 400,
                  ),
                  ..._controller.funds
                      .map((fund) => MenuCard(
                            fund: fund,
                            width: itemWidth,
                            height: 400,
                          ))
                      .toList(),
                ].toList(),
              ),
            ),
          ),
          Expanded(
            child: Visibility(
              visible: _controller.selectedFund.value != null &&
                  _controller.summariesFromFund.isNotEmpty,
              child: const TransactionsList(),
            ),
          )
        ],
      );
    });
  }
}
