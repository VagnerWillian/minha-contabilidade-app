import 'package:flutter/material.dart';

import '../../core.dart';

class CustomThemeColors extends ThemeExtension<CustomThemeColors> {
  final Color? staticPrimaryColor;
  final Color? successColor;
  final Color? failureColor;
  final Color? warningColor;
  final Color? grey200;
  final Color? grey500;
  final Color? white;
  final Color? black;

  CustomThemeColors({
    required this.staticPrimaryColor,
    required this.successColor,
    required this.failureColor,
    required this.warningColor,
    required this.grey200,
    required this.grey500,
    required this.white,
    required this.black,
  });

  @override
  ThemeExtension<CustomThemeColors> copyWith({
    Color? primaryColor,
    Color? successColor,
    Color? failureColor,
    Color? warningColor,
    Color? grey200,
    Color? black,
    Color? white,
  }) {
    return CustomThemeColors(
      staticPrimaryColor: primaryColor,
      successColor: successColor,
      failureColor: failureColor,
      warningColor: warningColor,
      grey200: grey200,
      grey500: grey500,
      black: black,
      white: white,
    );
  }

  @override
  ThemeExtension<CustomThemeColors> lerp(
      covariant ThemeExtension<CustomThemeColors>? other,
      double t,
      ) {
    if (other is! CustomThemeColors) return this;
    return CustomThemeColors(
      staticPrimaryColor: staticPrimaryColor,
      successColor: successColor,
      failureColor: failureColor,
      warningColor: warningColor,
      white: white,
      black: black,
      grey200: grey200,
      grey500: grey500,
    );
  }
}

extension FlavorThemeExtension on ThemeAdapter {
  ThemeData get getThemeData {
    return ThemeData(
      extensions: <CustomThemeColors>[
        CustomThemeColors(
          staticPrimaryColor: AppColors.staticPrimary,
          successColor: AppColors.success,
          failureColor: AppColors.error,
          warningColor: AppColors.warning,
          grey200: AppColors.grey200,
          grey500: AppColors.grey500,
          white: AppColors.white,
          black: AppColors.black,
        ),
      ],
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      dialogBackgroundColor: AppColors.dialogBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        secondary: AppColors.accent,
        tertiary: AppColors.brightness,
        error: AppColors.error,
      ),
      iconTheme: IconThemeData(color: AppColors.primary),
      textTheme: TextTheme(
        headlineLarge: AppTextStyles.headlineLarge(color: AppColors.grey500),
        headlineMedium: AppTextStyles.headlineMedium(color: AppColors.grey500),
        headlineSmall: AppTextStyles.headlineSmall(color: AppColors.grey500),
        titleLarge: AppTextStyles.titleLarge(color: AppColors.accent),
        titleMedium: AppTextStyles.titleMedium(color: AppColors.accent),
        titleSmall: AppTextStyles.titleSmall(color: AppColors.accent),
        displayLarge: AppTextStyles.displayLarge(color: AppColors.primary),
        displayMedium: AppTextStyles.displayMedium(color: AppColors.primary),
        displaySmall: AppTextStyles.displaySmall(color: AppColors.primary),
        bodyLarge: AppTextStyles.bodyLarge(color: AppColors.grey500),
        bodyMedium: AppTextStyles.bodyMedium(color: AppColors.grey500),
        bodySmall: AppTextStyles.bodySmall(color: AppColors.grey500),
      ),
    );
  }
}
