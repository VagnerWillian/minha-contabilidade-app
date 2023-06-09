import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String getPlural(int value) {
    if (value > 1) {
      if (endsWith('o')) {
        var newString = replaceRange(length - 1, length, '');
        return '${newString}os';
      } else if (endsWith('e')) {
        var newString = replaceRange(length - 1, length, '');
        return '${newString}es';
      }
    }
    return this;
  }

  String remotePoints() {
    return replaceAll('.', '').replaceAll('-', '');
  }

  bool get isAEmail => hasMatch(
      this,
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\'
      r'[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.'
      r')+[a-zA-Z]{2,}))$');

  bool get isAPhoneNumber {
    if (length > 16 || length < 9) return false;
    return hasMatch(this, r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  }

  bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  Color? get convertToColor {
    try {
      return HexColor(this);
    } catch (_) {}
    return null;
  }

  num tryConvertRealToDouble() {
    try {
      NumberFormat formatter = NumberFormat('R\$ #,##0.00', 'pt_BR');
      double result = formatter.parse(this).toDouble();
      return result;
    } catch (_) {
      print('Error in tryConvertRealToDouble($this)');
      return 0.0;
    }
  }

  String removeParentheses() {
    String str = replaceAll('(', '').replaceAll(')', '');
    return str;
  }
}
