import 'package:flutter/material.dart';

class CustomVisibility extends StatelessWidget {
  final Widget child;
  final bool visible;
  const CustomVisibility({
    super.key,
    this.visible = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (_) => visible ? child : const SizedBox.shrink(),
    );
  }
}
