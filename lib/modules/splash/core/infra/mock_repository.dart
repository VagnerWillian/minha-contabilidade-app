import '../../../../core/core.dart';
import '../domain/repositories/repositories.dart';

class MockSplashRepository implements SplashRepository{

  @override
  Future<UserEntity> getUserData(String uid) async{
    await Future.delayed(const Duration(seconds: 2));
    return UserProfile(
      active: true,
      name: 'Usuario',
      email: 'teste@teste.com',
      photo: '',
      uid: uid,
      cards: ['digio'],
      isAdmin: true,
      cpf: '123.456.789-10'
    );
  }
}