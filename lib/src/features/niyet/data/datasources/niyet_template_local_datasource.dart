import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/db/app_database.dart' as db;
import '../../domain/entities/niyet_category.dart';
import '../../domain/entities/niyet_template.dart';

abstract class NiyetTemplateLocalDataSource {
  Future<List<NiyetTemplate>> getTemplates();
  Future<NiyetTemplate> insertTemplate(NiyetTemplate template);
  Future<void> deleteTemplate(String id);
  Stream<List<NiyetTemplate>> watchTemplates();
}

@LazySingleton(as: NiyetTemplateLocalDataSource)
class NiyetTemplateLocalDataSourceImpl implements NiyetTemplateLocalDataSource {
  NiyetTemplateLocalDataSourceImpl(this._database);

  final db.AppDatabase _database;

  @override
  Future<List<NiyetTemplate>> getTemplates() async {
    final dbTemplates = await _database.getTemplates();
    return dbTemplates.map(_mapToEntity).toList();
  }

  @override
  Future<NiyetTemplate> insertTemplate(NiyetTemplate template) async {
    final companion = _mapToCompanion(template);
    await _database.insertTemplate(companion);
    return template;
  }

  @override
  Future<void> deleteTemplate(String id) async {
    await _database.deleteTemplate(id);
  }

  @override
  Stream<List<NiyetTemplate>> watchTemplates() {
    return _database.watchTemplates().map(
          (dbTemplates) => dbTemplates.map(_mapToEntity).toList(),
        );
  }

  NiyetTemplate _mapToEntity(db.NiyetTemplate dbTemplate) {
    return NiyetTemplate(
      id: dbTemplate.id,
      text: dbTemplate.templateText,
      category: NiyetCategory.values[dbTemplate.category],
      isDefault: false,
      createdAt: dbTemplate.createdAt,
    );
  }

  db.NiyetTemplatesCompanion _mapToCompanion(NiyetTemplate template) {
    return db.NiyetTemplatesCompanion(
      id: Value(template.id),
      templateText: Value(template.text),
      category: Value(template.category.index),
      createdAt: Value(template.createdAt ?? DateTime.now()),
    );
  }
}
