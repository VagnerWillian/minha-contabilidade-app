import '../entities/document_lgpd.dart';

abstract class GetDocumentsLGPDUseCaseInterface{
  Future<List<DocumentLGPDEntity>> call();
}