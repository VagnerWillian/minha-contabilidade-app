import 'package:flutter/material.dart';

import '../../adapters/theme_adapter/theme_adapter.dart';

class CustomDropDownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? items;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? iconEnabledColor;
  final Color? borderSideColor;
  final String? textHint;
  final VoidCallback? onTap;
  final bool expand;
  final FormFieldValidator<T>? validator;

  const CustomDropDownButton({
    Key? key,
    this.items = const [],
    this.value,
    this.textColor,
    this.backgroundColor,
    this.iconEnabledColor,
    this.borderSideColor,
    this.onChanged,
    this.onTap,
    this.textHint,
    this.validator,
    this.expand = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? ThemeAdapter(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: borderSideColor ?? ThemeAdapter(context).accentColor,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<T>(
            validator: validator,
            isExpanded: expand,
            value: value,
            hint: Text(
              textHint ?? 'Selecionar...',
              style: ThemeAdapter(context).bodySmall.copyWith(
                    color: textColor ?? ThemeAdapter(context).customColors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            style: ThemeAdapter(context).bodySmall.copyWith(
                  color: textColor ?? ThemeAdapter(context).customColors.white,
                  fontWeight: FontWeight.bold,
                ),
            iconEnabledColor: iconEnabledColor ?? ThemeAdapter(context).customColors.white,
            borderRadius: BorderRadius.circular(5),
            dropdownColor: backgroundColor ?? ThemeAdapter(context).primaryColor,
            items: items,
            onChanged: onChanged,
            decoration: const InputDecoration(
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
              focusColor: Colors.transparent
            ),
          ),
        ),
      ),
    );
  }
}
