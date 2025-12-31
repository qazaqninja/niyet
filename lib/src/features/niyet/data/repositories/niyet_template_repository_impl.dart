import 'package:injectable/injectable.dart';

import '../../../../core/base/base_usecase/result.dart';
import '../../domain/entities/niyet_template.dart';
import '../../domain/repositories/niyet_template_repository.dart';
import '../datasources/niyet_template_local_datasource.dart';

@LazySingleton(as: NiyetTemplateRepository)
class NiyetTemplateRepositoryImpl implements NiyetTemplateRepository {
  NiyetTemplateRepositoryImpl(this._localDataSource);

  final NiyetTemplateLocalDataSource _localDataSource;

  @override
  Future<Result<List<NiyetTemplate>>> getTemplates() async {
    try {
      final templates = await _localDataSource.getTemplates();
      return Result.success(templates);
    } catch (e) {
      return Result.failure(Exception('Failed to get templates: $e'));
    }
  }

  @override
  Future<Result<NiyetTemplate>> createTemplate(NiyetTemplate template) async {
    try {
      final created = await _localDataSource.insertTemplate(template);
      return Result.success(created);
    } catch (e) {
      return Result.failure(Exception('Failed to create template: $e'));
    }
  }

  @override
  Future<Result<void>> deleteTemplate(String id) async {
    try {
      await _localDataSource.deleteTemplate(id);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(Exception('Failed to delete template: $e'));
    }
  }

  @override
  Stream<List<NiyetTemplate>> watchTemplates() {
    return _localDataSource.watchTemplates();
  }
}
