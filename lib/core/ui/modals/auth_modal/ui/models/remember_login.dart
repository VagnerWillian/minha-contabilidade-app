import 'dart:convert';

class RememberLogin {
  late final bool biometrySecurity;
  late final bool remember;
  late final String email;
  late String pass;

  RememberLogin({
    this.biometrySecurity = false,
    required this.email,
    required this.pass,
    this.remember = false,
  });

  void clearPass() {
    pass = '';
  }

  RememberLogin.fromSource(String source) {
    var decoded = json.decode(source);
    biometrySecurity = decoded['hasBiometry'] ?? false;
    email = decoded['email'];
    pass = decoded['pass'];
    remember = decoded['remember'] ?? false;
  }

  String toSource() {
    var map = {
      'hasBiometry': biometrySecurity,
      'email': email,
      'pass': pass,
      'remember': remember,
    };
    return json.encode(map);
  }
}