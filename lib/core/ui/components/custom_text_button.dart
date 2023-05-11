import 'package:flutter/material.dart';
import '../../core.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.labelStyle,
  });

  final String label;
  final VoidCallback onPressed;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          AppColors.grey500.withOpacity(.1),
        ),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: labelStyle ?? ThemeAdapter(context).bodyMedium,
      ),
    );
  }
}
