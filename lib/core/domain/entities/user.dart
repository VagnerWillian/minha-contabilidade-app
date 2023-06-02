abstract class UserEntity{
  late String uid;
  late String name;
  late String email;
  late String cpf;
  late bool active;
  late bool isAdmin;
  late String? pushToken;
  late String? deviceId;
  late String photo;
  late List<dynamic> cards;
  Map<String, dynamic> get toJson;
}