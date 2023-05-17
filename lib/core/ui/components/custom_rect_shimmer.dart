import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../adapters/adapters.dart';

class CustomRectShimmer extends StatelessWidget {
  final Widget? child;
  final Color? baseColor;
  final Color? highlightColor;
  final double? height;

  const CustomRectShimmer({
    super.key,
    this.baseColor,
    this.highlightColor,
    this.height,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? ThemeAdapter(context).customColors.blue50!,
      highlightColor: highlightColor ?? ThemeAdapter(context).scaffoldBackgroundColor,
      child: child ??
          Container(
            height: height ?? 18,
            decoration: BoxDecoration(
              color: ThemeAdapter(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
    );
  }
}
