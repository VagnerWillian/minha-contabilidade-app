import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unicons/unicons.dart';

import '../../core.dart';

class CustomTextField extends StatefulWidget {
  final Color? backgroundColor;
  final String hint;
  final List<TextInputFormatter> masks;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FormFieldValidator? validator;
  final String? initialValue;
  final bool obscureText;
  final bool showObscureText;
  final bool autoValidate;
  final TextInputType? textInputType;
  final bool enabled;
  final bool textBold;
  final Color? textColor;

  const CustomTextField({
    super.key,
    this.backgroundColor,
    this.hint = '',
    this.masks = const [],
    this.onChanged,
    this.controller,
    this.focusNode,
    this.validator,
    this.initialValue,
    this.textInputType,
    this.textColor,
    this.textBold = false,
    this.obscureText = false,
    this.autoValidate = false,
    this.showObscureText = true,
    this.enabled = true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _filled = false;
  bool _showObscureText = false;
  late FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _focus = widget.focusNode ?? FocusNode();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus
      ..removeListener(_onFocusChange)
      ..dispose();
  }

  void _onFocusChange() {
    setState(() => _filled = _focus.hasFocus);
  }

  void _setShowObscureText() {
    setState(() => _showObscureText = !_showObscureText);
  }

  @override
  Widget build(BuildContext context) {
    var defaultStyle = ThemeAdapter(context).bodyMedium.copyWith(
          color: !widget.enabled
              ? ThemeAdapter(context).customColors.grey500
              : widget.textColor ?? ThemeAdapter(context).bodyMedium.color,
          fontWeight: !widget.textBold ? null : FontWeight.bold,
        );
    var focusColor = widget.textColor ?? ThemeAdapter(context).primaryColor;

    var errorBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: ThemeAdapter(context).error,
        width: 2,
      ),
    );

    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? ThemeAdapter(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            enabled: widget.enabled,
            controller: widget.controller,
            onChanged: widget.onChanged,
            inputFormatters: widget.masks,
            focusNode: _focus,
            keyboardType: widget.textInputType,
            textAlign: TextAlign.center,
            validator: widget.validator,
            autovalidateMode:
                widget.autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
            initialValue: widget.initialValue,
            obscureText: widget.obscureText && !_showObscureText,
            buildCounter: (
              BuildContext context, {
              required int currentLength,
              required int? maxLength,
              required bool isFocused,
            }) =>
                const Text(''),
            decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ThemeAdapter(context).customColors.grey500!,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: focusColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: focusColor,
                  width: 2,
                ),
              ),
              errorBorder: errorBorder,
              focusedErrorBorder: errorBorder,
              fillColor: focusColor.withOpacity(.05),
              filled: _filled,
              hintText: widget.hint,
              hintStyle: defaultStyle,
            ),
            style: defaultStyle,
          ),
        ),
        Visibility(
          visible: widget.showObscureText && widget.obscureText,
          child: Positioned(
            top: 8,
            right: 5,
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: _setShowObscureText,
                alignment: Alignment.center,
                icon: Icon(
                  _showObscureText ? UniconsLine.eye : UniconsLine.eye_slash,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
