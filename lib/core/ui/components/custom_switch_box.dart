import 'package:flutter/material.dart';
import '../../adapters/theme_adapter/theme_adapter.dart';
import '../../core.dart';

class CustomSwitchBox extends StatelessWidget {
  final String? label;
  final bool value;
  final bool enabled;
  final ValueChanged<bool?>? onChanged;
  final Color? fillColor;
  final Color? inactiveThumbColor;
  final TextStyle? labelStyle;

  const CustomSwitchBox({
    super.key,
    this.label,
    required this.value,
    this.onChanged,
    this.enabled = true,
    this.fillColor,
    this.inactiveThumbColor,
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
            Switch(
              value: value,
              onChanged: enabled ? onChanged : null,
              activeColor: enabled ? fillColor : ThemeAdapter(context).customColors.grey500!,
              inactiveThumbColor:
                  enabled ? inactiveThumbColor : ThemeAdapter(context).customColors.grey500!,
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
