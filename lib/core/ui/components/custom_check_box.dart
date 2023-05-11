import 'package:flutter/material.dart';
import '../../adapters/theme_adapter/theme_adapter.dart';
import '../../core.dart';

class CustomCheckBox extends StatelessWidget {
  final String? label;
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Color? fillColor;
  final TextStyle? labelStyle;

  const CustomCheckBox({
    super.key,
    this.label,
    required this.value,
    this.onChanged,
    this.fillColor,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        checkboxTheme: Theme.of(context).checkboxTheme.copyWith(
              side: BorderSide(
                color: fillColor ?? ThemeAdapter(context).primaryColor,
              ),
              fillColor: MaterialStatePropertyAll(
                fillColor ?? ThemeAdapter(context).primaryColor,
              ),
            ),
      ),
      child: SizedBox(
        height: 18,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              fillColor: MaterialStateProperty.all(ThemeAdapter(context).primaryColor),
            ),
            Text(
              label ?? '',
              style: labelStyle ?? ThemeAdapter(context).bodySmall.copyWith(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
