import '../domain/entities/entities.dart';
import '../domain/repositories/repository.dart';

class GetAllBrandsUseCase{
  final FundsRepository _repository;
  GetAllBrandsUseCase(this._repository);

  Future<List<BrandEntity>> call()async{
    return await _repository.getAllBrands();
  }
}