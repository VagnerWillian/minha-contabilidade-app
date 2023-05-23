import '../../../../../core/core.dart';
import '../entities/brand_entity.dart';

abstract class FundsRepository {
  Future<List<FundEntity>> getAllFunds();
  Future<List<BrandEntity>> getAllBrands();
  Future<void> createFund(Map<String, dynamic> data);
  Future<void> deleteFund(String id);
}
