import '../../core.dart';

class UserProfile implements UserEntity {

  @override
  late final bool active;

  @override
  late final bool isAdmin;

  @override
  late final String name;

  @override
  late final String photo;

  @override
  late final String? pushToken;

  @override
  late final String uid;

  @override
  late final String? deviceId;

  @override
  late final String email;

  @override
  late final List<dynamic> cards;

  @override
  Map<String, dynamic> get toJson => {
        'uid': uid,
        'nome': name,
        'email': email,
        'ativo': active,
        'admin': isAdmin,
        'pushToken': pushToken,
        'deviceId': deviceId,
        'foto': photo,
        'cards': cards,
      };

  UserProfile({
    required this.active,
    required this.isAdmin,
    required this.name,
    required this.photo,
    required this.pushToken,
    required this.uid,
    required this.cards,
  });

  UserProfile.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['nome'];
    email = json['email'];
    active = json['ativo'];
    isAdmin = json['admin'];
    pushToken = json['pushToken'];
    deviceId = json['deviceId'];
    photo = json['foto'];
    cards = json['cards'];
  }

}
