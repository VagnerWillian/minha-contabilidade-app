import 'package:flutter/material.dart';

import '../../core.dart';

class ThemeAdapter {
  final BuildContext _context;
  ThemeAdapter(this._context);

  Color get scaffoldBackgroundColor => Theme.of(_context).scaffoldBackgroundColor;
  Color get dialogBackgroundColor => Theme.of(_context).dialogBackgroundColor;
  Color get primaryColor => Theme.of(_context).primaryColor;
  Color get accentColor => Theme.of(_context).colorScheme.secondary;
  Color get accentSecondaryColor => Theme.of(_context).colorScheme.tertiary;
  Color get error => Theme.of(_context).colorScheme.error;
  Color get iconColor => Theme.of(_context).iconTheme.color!;
  CustomThemeColors get customColors => Theme.of(_context).extension<CustomThemeColors>()!;

  TextStyle get headlineLarge => Theme.of(_context).textTheme.headlineLarge!;
  TextStyle get headlineMedium => Theme.of(_context).textTheme.headlineMedium!;
  TextStyle get headlineSmall => Theme.of(_context).textTheme.headlineSmall!;
  TextStyle get titleLarge => Theme.of(_context).textTheme.titleLarge!;
  TextStyle get titleMedium => Theme.of(_context).textTheme.titleMedium!;
  TextStyle get titleSmall => Theme.of(_context).textTheme.titleSmall!;

  TextStyle get displayLarge => Theme.of(_context).textTheme.displayLarge!;
  TextStyle get displayMedium => Theme.of(_context).textTheme.displayMedium!;
  TextStyle get displaySmall => Theme.of(_context).textTheme.displaySmall!;
  TextStyle get bodyLarge => Theme.of(_context).textTheme.bodyLarge!;
  TextStyle get bodyMedium => Theme.of(_context).textTheme.bodyMedium!;
  TextStyle get bodySmall => Theme.of(_context).textTheme.bodySmall!;
}
