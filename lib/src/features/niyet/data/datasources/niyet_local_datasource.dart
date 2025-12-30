import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/db/app_database.dart';
import '../../domain/entities/niyet.dart' as entity;
import '../../domain/entities/niyet_category.dart';
import '../../domain/entities/niyet_outcome.dart';

abstract class NiyetLocalDataSource {
  Future<List<entity.Niyet>> getTodayNiyetler();
  Future<List<entity.Niyet>> getNiyetlerByDate(DateTime date);
  Future<List<entity.Niyet>> getNiyetlerInRange(DateTime start, DateTime end);
  Future<entity.Niyet> insertNiyet(entity.Niyet niyet);
  Future<entity.Niyet> updateNiyet(entity.Niyet niyet);
  Future<void> deleteNiyet(String id);
  Stream<List<entity.Niyet>> watchTodayNiyetler();
}

@LazySingleton(as: NiyetLocalDataSource)
class NiyetLocalDataSourceImpl implements NiyetLocalDataSource {
  NiyetLocalDataSourceImpl(this._database);

  final AppDatabase _database;

  @override
  Future<List<entity.Niyet>> getTodayNiyetler() async {
    final dbNiyetler = await _database.getTodayNiyetler();
    return dbNiyetler.map(_mapToEntity).toList();
  }

  @override
  Future<List<entity.Niyet>> getNiyetlerByDate(DateTime date) async {
    final dbNiyetler = await _database.getNiyetlerByDate(date);
    return dbNiyetler.map(_mapToEntity).toList();
  }

  @override
  Future<List<entity.Niyet>> getNiyetlerInRange(
    DateTime start,
    DateTime end,
  ) async {
    final dbNiyetler = await _database.getNiyetlerInRange(start, end);
    return dbNiyetler.map(_mapToEntity).toList();
  }

  @override
  Future<entity.Niyet> insertNiyet(entity.Niyet niyet) async {
    final companion = _mapToCompanion(niyet);
    await _database.insertNiyet(companion);
    return niyet;
  }

  @override
  Future<entity.Niyet> updateNiyet(entity.Niyet niyet) async {
    final companion = _mapToCompanion(niyet);
    await _database.updateNiyet(companion);
    return niyet;
  }

  @override
  Future<void> deleteNiyet(String id) async {
    await _database.deleteNiyet(id);
  }

  @override
  Stream<List<entity.Niyet>> watchTodayNiyetler() {
    return _database.watchTodayNiyetler().map(
          (dbNiyetler) => dbNiyetler.map(_mapToEntity).toList(),
        );
  }

  entity.Niyet _mapToEntity(NiyetlerData db) {
    return entity.Niyet(
      id: db.id,
      date: db.date,
      text: db.niyetText,
      category: NiyetCategory.values[db.category],
      outcome: db.outcome != null ? NiyetOutcome.values[db.outcome!] : null,
      reflection: db.reflection,
      forAllah: db.forAllah,
      createdAt: db.createdAt,
      updatedAt: db.updatedAt,
    );
  }

  NiyetlerCompanion _mapToCompanion(entity.Niyet niyet) {
    return NiyetlerCompanion(
      id: Value(niyet.id),
      date: Value(niyet.date),
      niyetText: Value(niyet.text),
      category: Value(niyet.category.index),
      outcome: Value(niyet.outcome?.index),
      reflection: Value(niyet.reflection),
      forAllah: Value(niyet.forAllah),
      createdAt: Value(niyet.createdAt),
      updatedAt: Value(niyet.updatedAt),
    );
  }
}
