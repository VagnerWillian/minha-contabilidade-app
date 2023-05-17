import 'package:flutter/material.dart';

import '../../core.dart';

class ThemeAdapter {
  final BuildContext context;
  ThemeAdapter(this.context);

  Color get scaffoldBackgroundColor => Theme.of(context).scaffoldBackgroundColor;
  Color get dialogBackgroundColor => Theme.of(context).dialogBackgroundColor;
  Color get primaryColor => Theme.of(context).primaryColor;
  Color get accentColor => Theme.of(context).colorScheme.secondary;
  Color get accentSecondaryColor => Theme.of(context).colorScheme.tertiary;
  Color get error => Theme.of(context).colorScheme.error;
  Color get iconColor => Theme.of(context).iconTheme.color!;
  CustomThemeColors get customColors => Theme.of(context).extension<CustomThemeColors>()!;

  TextStyle get headlineLarge => Theme.of(context).textTheme.headlineLarge!;
  TextStyle get headlineMedium => Theme.of(context).textTheme.headlineMedium!;
  TextStyle get headlineSmall => Theme.of(context).textTheme.headlineSmall!;
  TextStyle get titleLarge => Theme.of(context).textTheme.titleLarge!;
  TextStyle get titleMedium => Theme.of(context).textTheme.titleMedium!;
  TextStyle get titleSmall => Theme.of(context).textTheme.titleSmall!;

  TextStyle get displayLarge => Theme.of(context).textTheme.displayLarge!;
  TextStyle get displayMedium => Theme.of(context).textTheme.displayMedium!;
  TextStyle get displaySmall => Theme.of(context).textTheme.displaySmall!;
  TextStyle get bodyLarge => Theme.of(context).textTheme.bodyLarge!;
  TextStyle get bodyMedium => Theme.of(context).textTheme.bodyMedium!;
  TextStyle get bodySmall => Theme.of(context).textTheme.bodySmall!;

  ThemeData get getThemeData {
    return ThemeData(
      extensions: <CustomThemeColors>[
        CustomThemeColors(
          successColor: AppColors.success,
          failureColor: AppColors.error,
          warningColor: AppColors.warning,
          grey200: AppColors.grey200,
          grey300: AppColors.grey300,
          grey400: AppColors.grey400,
          grey500: AppColors.grey500,
          white: AppColors.white,
          black: AppColors.black,
          blackGrey: AppColors.blackGrey,
          green: AppColors.green,
          blue50: AppColors.blue50
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
