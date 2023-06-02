import '../../../../../../core.dart';
import '../../domain/repositories/repositories.dart';

class MockAuthModalRepository implements AuthModalRepository {
  @override
  Future<UserEntity> getUserData(String uid) async {
    await Future.delayed(const Duration(seconds: 2));
    return UserProfile(
      active: true,
      name: 'Usuario',
      email: 'teste@teste.com',
      cpf: '123.456.789-10',
      photo: '',
      uid: '',
      cards: ['digio'],
      isAdmin: true
    );
  }
}
