import '../domain/entities/entities.dart';

abstract class StartRepository{
  Future<List<SpecialtyQueueEntity>> getSpecialties();
  Future<SpecialtyQueueEntity> getQueueFromSpecialty(int idSpecialty);
}