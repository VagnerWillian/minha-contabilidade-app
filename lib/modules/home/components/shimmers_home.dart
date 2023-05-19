import 'package:flutter/material.dart';

import '../../../core/core.dart';

class ShimmerProgress {
  static Widget summariesShimmer(BuildContext context) => CustomRectShimmer(
        baseColor: ThemeAdapter(context).customColors.blue50,
        highlightColor: ThemeAdapter(context).scaffoldBackgroundColor,
      );

  static Widget transactionsShimmer(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          CustomRectShimmer(
            height: 80,
            baseColor: ThemeAdapter(context).customColors.blue50,
            highlightColor: ThemeAdapter(context).scaffoldBackgroundColor,
          ),
          const SizedBox(height: 10),
          CustomRectShimmer(
            height: 80,
            baseColor: ThemeAdapter(context).customColors.blue50,
            highlightColor: ThemeAdapter(context).scaffoldBackgroundColor,
          ),
          const SizedBox(height: 10),
          CustomRectShimmer(
            height: 80,
            baseColor: ThemeAdapter(context).customColors.blue50,
            highlightColor: ThemeAdapter(context).scaffoldBackgroundColor,
          ),
          const SizedBox(height: 10),
          CustomRectShimmer(
            height: 80,
            baseColor: ThemeAdapter(context).customColors.blue50,
            highlightColor: ThemeAdapter(context).scaffoldBackgroundColor,
          ),
        ],
      );

  static Widget cardsShimmerH(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
          children: [
            const SizedBox(width: 80),
            SizedBox(
              width: 250,
              child: CustomRectShimmer(
                height: 400,
                baseColor: ThemeAdapter(context).customColors.blue50,
                highlightColor: ThemeAdapter(context).scaffoldBackgroundColor,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 250,
              child: CustomRectShimmer(
                height: 400,
                baseColor: ThemeAdapter(context).customColors.blue50,
                highlightColor: ThemeAdapter(context).scaffoldBackgroundColor,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 250,
              child: CustomRectShimmer(
                height: 400,
                baseColor: ThemeAdapter(context).customColors.blue50,
                highlightColor: ThemeAdapter(context).scaffoldBackgroundColor,
              ),
            ),
          ],
        ),
  );

  static Widget cardsShimmerV(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    width: 400,
    child: Column(
      children: [
        Container(
          height: 400,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: CustomRectShimmer(
            baseColor: ThemeAdapter(context).customColors.blue50,
            highlightColor: ThemeAdapter(context).scaffoldBackgroundColor,
          ),
        ),
        Container(
          height: 400,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: CustomRectShimmer(
            baseColor: ThemeAdapter(context).customColors.blue50,
            highlightColor: ThemeAdapter(context).scaffoldBackgroundColor,
          ),
        ),
      ],
    ),
  );
}
