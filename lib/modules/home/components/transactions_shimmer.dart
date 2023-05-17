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
}
