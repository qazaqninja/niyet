import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/db/app_database.dart';
import '../../domain/entities/niyyah.dart' as entity;
import '../../domain/entities/niyyah_category.dart';
import '../../domain/entities/niyyah_outcome.dart';

abstract class NiyyahLocalDataSource {
  Future<List<entity.Niyyah>> getTodayNiyyat();
  Future<List<entity.Niyyah>> getNiyyatByDate(DateTime date);
  Future<List<entity.Niyyah>> getNiyyatInRange(DateTime start, DateTime end);
  Future<entity.Niyyah> insertNiyyah(entity.Niyyah niyyah);
  Future<entity.Niyyah> updateNiyyah(entity.Niyyah niyyah);
  Future<void> deleteNiyyah(String id);
  Stream<List<entity.Niyyah>> watchTodayNiyyat();
}

@LazySingleton(as: NiyyahLocalDataSource)
class NiyyahLocalDataSourceImpl implements NiyyahLocalDataSource {
  NiyyahLocalDataSourceImpl(this._database);

  final AppDatabase _database;

  @override
  Future<List<entity.Niyyah>> getTodayNiyyat() async {
    final dbNiyyat = await _database.getTodayNiyyat();
    return dbNiyyat.map(_mapToEntity).toList();
  }

  @override
  Future<List<entity.Niyyah>> getNiyyatByDate(DateTime date) async {
    final dbNiyyat = await _database.getNiyyatByDate(date);
    return dbNiyyat.map(_mapToEntity).toList();
  }

  @override
  Future<List<entity.Niyyah>> getNiyyatInRange(
    DateTime start,
    DateTime end,
  ) async {
    final dbNiyyat = await _database.getNiyyatInRange(start, end);
    return dbNiyyat.map(_mapToEntity).toList();
  }

  @override
  Future<entity.Niyyah> insertNiyyah(entity.Niyyah niyyah) async {
    final companion = _mapToCompanion(niyyah);
    await _database.insertNiyyah(companion);
    return niyyah;
  }

  @override
  Future<entity.Niyyah> updateNiyyah(entity.Niyyah niyyah) async {
    final companion = _mapToCompanion(niyyah);
    await _database.updateNiyyah(companion);
    return niyyah;
  }

  @override
  Future<void> deleteNiyyah(String id) async {
    await _database.deleteNiyyah(id);
  }

  @override
  Stream<List<entity.Niyyah>> watchTodayNiyyat() {
    return _database.watchTodayNiyyat().map(
          (dbNiyyat) => dbNiyyat.map(_mapToEntity).toList(),
        );
  }

  entity.Niyyah _mapToEntity(NiyyatData db) {
    return entity.Niyyah(
      id: db.id,
      date: db.date,
      text: db.niyyahText,
      category: NiyyahCategory.values[db.category],
      outcome: db.outcome != null ? NiyyahOutcome.values[db.outcome!] : null,
      reflection: db.reflection,
      forAllah: db.forAllah,
      createdAt: db.createdAt,
      updatedAt: db.updatedAt,
    );
  }

  NiyyatCompanion _mapToCompanion(entity.Niyyah niyyah) {
    return NiyyatCompanion(
      id: Value(niyyah.id),
      date: Value(niyyah.date),
      niyyahText: Value(niyyah.text),
      category: Value(niyyah.category.index),
      outcome: Value(niyyah.outcome?.index),
      reflection: Value(niyyah.reflection),
      forAllah: Value(niyyah.forAllah),
      createdAt: Value(niyyah.createdAt),
      updatedAt: Value(niyyah.updatedAt),
    );
  }
}
