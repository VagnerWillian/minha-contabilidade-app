import 'package:flutter/material.dart';

import '../../../core/core.dart';

class ShimmerProgress {
  static Widget cardsShimmerH(BuildContext context) => SizedBox(
    height: 250,
    child: CustomRectShimmer(
      baseColor: ThemeAdapter(context).customColors.blue50,
      highlightColor: ThemeAdapter(context).scaffoldBackgroundColor,
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
