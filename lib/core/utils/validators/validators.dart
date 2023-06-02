import 'package:get/get.dart';

import '../../core.dart';

class Validators {
  static String? validateEmail(String value) {
    if (value!.isEmpty) {
      return 'Campo obrigatório';
    } else if (!value.isAEmail) {
      return 'E-mail inválido';
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

  static String? validateTextEmpty(str) {
    if (str.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  static String? validateName(str) {
    if (str.isEmpty) return 'Campo obrigatório';
    RegExp regExp = RegExp(r'^[a-zA-Z]+ [a-zA-Z]+$');
    if(!regExp.hasMatch(str)) return 'Nome e Sobrenome inválido';
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

  static String? validateMinLength(String? value, int length) {
    if (value!.removeAllWhitespace.length < length) return 'Mínimo $length caracteres.';
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (validateMinLength(value, 13) != null) return 'Celular inválido';
    return null;
  }

  static String? validateEqual(String value1, String value2, String message){
    if(value1!=value2) return message;
    return null;
  }

  static String? validateCPF(String? value){
    if(!GetUtils.isCpf(value!)) return 'CPF inválido';
    return null;
  }
}
