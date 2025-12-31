import '../../../../core/base/base_usecase/result.dart';
import '../entities/niyet_template.dart';

abstract class NiyetTemplateRepository {
  Future<Result<List<NiyetTemplate>>> getTemplates();
  Future<Result<NiyetTemplate>> createTemplate(NiyetTemplate template);
  Future<Result<void>> deleteTemplate(String id);
  Stream<List<NiyetTemplate>> watchTemplates();
}
