import 'package:flutter/material.dart';
import '../../core.dart';

class CustomRectangleButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Size? size;
  final TextStyle? labelStyle;
  final Alignment? textAlign;
  final IconButton? suffixIcon;
  final Widget? prefixIcon;
  final Color? background;
  final BorderSide? borderStyle;
  final Color? splash;
  final double? borderRadius;

  const CustomRectangleButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.size,
    this.labelStyle,
    this.textAlign,
    this.suffixIcon,
    this.prefixIcon,
    this.background,
    this.splash,
    this.borderRadius,
    this.borderStyle = BorderSide.none,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        fixedSize: size,
        backgroundColor: background ?? ThemeAdapter(context).primaryColor,
        disabledBackgroundColor: ThemeAdapter(context).customColors.grey500,
        disabledForegroundColor: ThemeAdapter(context).customColors.white,
        shadowColor: Colors.transparent,
        textStyle: labelStyle,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
          side: borderStyle!,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment:
            suffixIcon != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: prefixIcon != null,
                  child: prefixIcon ?? const SizedBox(),
                ),
                Visibility(
                  visible: label.isNotEmpty,
                  child: Expanded(
                    child: Align(
                      alignment: textAlign ?? Alignment.center,
                      child: Text(
                        '${prefixIcon != null ? ' ' : ''}$label',
                        style: labelStyle?.copyWith(fontWeight: FontWeight.bold) ??
                            ThemeAdapter(context).displayMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: ThemeAdapter(context).customColors.white,
                                ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: suffixIcon != null,
            child: suffixIcon ?? const SizedBox(),
          ),
        ],
      ),
    );
  }
}
