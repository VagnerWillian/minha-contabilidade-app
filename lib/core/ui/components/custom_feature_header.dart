import 'package:flutter/material.dart';

import '../../core.dart';

class CustomFeatureHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool centerContent;
  final Color? titleColor;
  const CustomFeatureHeader({
    required this.title,
    this.subtitle,
    this.centerContent = true,
    this.titleColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              textAlign: !centerContent ? null : TextAlign.center,
              style: ThemeAdapter(context).displayLarge.copyWith(
                color: titleColor
              ),
            ),
            Visibility(
              visible: subtitle!=null,
              child: Text(
                subtitle??'',
                textAlign: !centerContent ? null : TextAlign.center,
                style: ThemeAdapter(context).headlineSmall,
              ),
            ),
            const Expanded(child: SizedBox())
          ],
        ),
      ),
    );
  }
}
