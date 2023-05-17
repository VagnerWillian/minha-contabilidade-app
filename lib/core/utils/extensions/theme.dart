import 'package:flutter/material.dart';

class CustomThemeColors extends ThemeExtension<CustomThemeColors> {
  final Color? successColor;
  final Color? failureColor;
  final Color? warningColor;
  final Color? grey200;
  final Color? grey300;
  final Color? grey400;
  final Color? grey500;
  final Color? green;
  final Color? white;
  final Color? black;
  final Color? blackGrey;
  final Color? blue50;

  CustomThemeColors({
    required this.successColor,
    required this.failureColor,
    required this.warningColor,
    required this.grey200,
    required this.grey500,
    required this.grey300,
    required this.grey400,
    required this.green,
    required this.white,
    required this.black,
    required this.blackGrey,
    required this.blue50,
  });

  @override
  ThemeExtension<CustomThemeColors> copyWith({
    Color? primaryColor,
    Color? successColor,
    Color? failureColor,
    Color? warningColor,
    Color? grey200,
    Color? grey300,
    Color? grey400,
    Color? grey500,
    Color? green,
    Color? black,
    Color? blackGrey,
    Color? blue50,
    Color? white,
  }) {
    return CustomThemeColors(
      successColor: successColor,
      failureColor: failureColor,
      warningColor: warningColor,
      grey200: grey200,
      grey500: grey500,
      grey300: grey300,
      grey400: grey400,
      black: black,
      blackGrey: blackGrey,
      white: white,
      green: green,
      blue50: blue50,
    );
  }

  @override
  ThemeExtension<CustomThemeColors> lerp(
      covariant ThemeExtension<CustomThemeColors>? other,
      double t,
      ) {
    if (other is! CustomThemeColors) return this;
    return CustomThemeColors(
      successColor: successColor,
      failureColor: failureColor,
      warningColor: warningColor,
      white: white,
      black: black,
      blackGrey: blackGrey,
      grey200: grey200,
      grey500: grey500,
      grey300: grey300,
      grey400: grey400,
      green: green,
      blue50: blue50,
    );
  }
}
