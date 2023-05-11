import 'package:flutter/material.dart';

import '../../core.dart';

class CustomCircleProgress extends StatelessWidget {
  final double? width;
  final double? height;
  const CustomCircleProgress({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 80.0,
      height: height ?? 80.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: ThemeAdapter(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
