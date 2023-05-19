import 'package:get/get.dart';

import '../../core.dart';

class Validators {
  static String? validateEmailAndPhone(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    } else if (!value.isAEmail && !value.isAPhoneNumber) {
      return 'E-mail ou Telefone inválido';
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  static String? validateColor(String colorHex) {
    var color = colorHex.convertToColor;
    if (color == null) return 'Cor inválida';
    return null;
  }

  static String? validateTextEmpty(String str) {
    if (str.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  static String? validateIsNotNull(dynamic value) {
    if (value == null) {
      return 'Campo obrigatório';
    }
    return null;
  }

  static String? validateUrl(String value, {emptyPermitted = false}) {
    if (!emptyPermitted) return 'Campo obrigatório';
    if (value.isNotEmpty && !GetUtils.isURL(value)) return 'Url Inválida';
    return null;
  }
}
