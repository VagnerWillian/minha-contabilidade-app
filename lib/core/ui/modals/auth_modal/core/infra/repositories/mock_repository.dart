import '../../../../../../core.dart';
import '../../domain/repositories/repositories.dart';

class MockAuthModalRepository implements AuthModalRepository {
  @override
  Future<UserEntity> getUserData() async {
    await Future.delayed(const Duration(seconds: 2));
    return UserProfile(
      active: true,
      name: 'Usuario',
      photo: '',
      pushToken: '',
      uid: '',
    );
  }
}
