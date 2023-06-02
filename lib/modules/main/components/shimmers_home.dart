import 'package:flutter/cupertino.dart';

import '../../../core/core.dart';

class ShimmersHome {
  static Widget get shimmerUsers => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: List.generate(
            6,
            (index) => Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: const CustomRectShimmer(height: 60),
            ),
          ).toList(),
        ),
      );
}
