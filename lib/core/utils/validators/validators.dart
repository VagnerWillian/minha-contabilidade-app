import '../../core.dart';

class Validators {
  static String? validateEmailAndPhone(String value) {
    if(value.isEmpty){
      return 'Campo obrigatório';
    }else if (!value.isAEmail&&!value.isAPhoneNumber) {
      return 'E-mail ou Telefone inválido';
    }
    return null;
  }

  static String? validatePassword(String value){
    if(value.isEmpty){
      return 'Campo obrigatório';
    }
    return null;
  }
}
