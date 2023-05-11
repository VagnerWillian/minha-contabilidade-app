import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomRectShimmer extends StatelessWidget {
  final Widget child;
  const CustomRectShimmer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.tertiary,
      highlightColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
      child: child,
    );
  }
}
