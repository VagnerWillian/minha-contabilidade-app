import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle defaultFont = TextStyle();

  static TextStyle bodyLarge({
    double fontSize = 26,
    Color color = Colors.black87,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) =>
      defaultFont.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  static TextStyle bodyMedium({
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black87,
    double letterSpacing = 0,
  }) =>
      defaultFont.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  static TextStyle bodySmall({
    double fontSize = 14,
    Color color = Colors.black87,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) =>
      defaultFont.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  static TextStyle displayLarge({
    double fontSize = 26,
    Color color = Colors.black87,
    FontWeight fontWeight = FontWeight.bold,
    double letterSpacing = 0,
  }) =>
      defaultFont.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  static TextStyle displayMedium({
    double fontSize = 18,
    Color color = Colors.black87,
    FontWeight fontWeight = FontWeight.bold,
    double letterSpacing = 0,
  }) =>
      defaultFont.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  static TextStyle displaySmall({
    double fontSize = 14,
    Color color = Colors.black87,
    FontWeight fontWeight = FontWeight.bold,
    double letterSpacing = 0,
  }) =>
      defaultFont.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  static TextStyle headlineLarge({
    double fontSize = 30,
    Color color = Colors.black87,
    FontWeight fontWeight = FontWeight.bold,
    double letterSpacing = 0,
  }) =>
      defaultFont.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  static TextStyle headlineMedium({
    double fontSize = 24,
    Color color = Colors.black87,
    FontWeight fontWeight = FontWeight.bold,
    double letterSpacing = 0,
  }) =>
      defaultFont.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  static TextStyle headlineSmall({
    double fontSize = 14,
    Color color = Colors.black87,
    FontWeight fontWeight = FontWeight.bold,
    double letterSpacing = 0,
  }) =>
      defaultFont.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  static TextStyle titleLarge({
    double fontSize = 30,
    Color color = Colors.black87,
    FontWeight fontWeight = FontWeight.bold,
    double letterSpacing = 0,
  }) =>
      defaultFont.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  static TextStyle titleMedium({
    double fontSize = 24,
    Color color = Colors.black87,
    FontWeight fontWeight = FontWeight.bold,
    double letterSpacing = 0,
  }) =>
      defaultFont.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  static TextStyle titleSmall({
    double fontSize = 14,
    Color color = Colors.black87,
    FontWeight fontWeight = FontWeight.bold,
    double letterSpacing = 0,
  }) =>
      defaultFont.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );
}
