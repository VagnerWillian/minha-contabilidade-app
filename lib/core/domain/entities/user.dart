abstract class UserEntity{
  late String uid;
  late String name;
  late String email;
  late bool active;
  late String? pushToken;
  late String? deviceId;
  late String photo;
  Map<String, dynamic> get toJson;
}