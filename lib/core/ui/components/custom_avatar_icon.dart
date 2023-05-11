import 'package:flutter/material.dart';

import '../../core.dart';

class CustomAvatarIcon extends StatelessWidget {
  final Color? color;
  final IconData icon;
  final double fontSize;

  const CustomAvatarIcon({
    super.key,
    required this.icon,
    this.color,
    this.fontSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    Color defColor = color??ThemeAdapter(context).primaryColor;
    return Center(
      child: CircleAvatar(
        backgroundColor: defColor.withOpacity(0.2),
        child: Icon(
          icon,
          size: fontSize,
          color: defColor,
        ),
      ),
    );
  }
}
