import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// Niyetler table (plural of niyet in Arabic)
class Niyetler extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get niyetText => text()();
  IntColumn get category => integer()();
  IntColumn get outcome => integer().nullable()();
  TextColumn get reflection => text().nullable()();
  BoolColumn get forAllah => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// User-created niyet templates
class NiyetTemplates extends Table {
  TextColumn get id => text()();
  TextColumn get templateText => text()();
  IntColumn get category => integer()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Niyetler, NiyetTemplates])
class AppDatabase extends _$AppDatabase {
  AppDatabase._() : super(_openConnection());

  static AppDatabase? _instance;

  static AppDatabase get instance {
    _instance ??= AppDatabase._();
    return _instance!;
  }

  static Future<void> init() async {
    _instance ??= AppDatabase._();
  }

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Migration v1 -> v2: Table renamed from 'niyyat' to 'niyetler'
        if (from < 2) {
          // Use DROP IF EXISTS to handle edge case where table doesn't exist
          await customStatement('DROP TABLE IF EXISTS niyyat');
          await m.createAll();
        }
        // Migration v2 -> v3: Add niyet_templates table
        if (from < 3) {
          await m.createTable(niyetTemplates);
        }
      },
    );
  }

  // Niyet CRUD operations
  Future<List<NiyetlerData>> getNiyetlerByDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    return (select(niyetler)
          ..where((t) =>
              t.date.isBiggerOrEqualValue(startOfDay) &
              t.date.isSmallerThanValue(endOfDay)))
        .get();
  }

  Future<List<NiyetlerData>> getTodayNiyetler() => getNiyetlerByDate(DateTime.now());

  Future<int> insertNiyet(NiyetlerCompanion entry) => into(niyetler).insert(entry);

  Future<bool> updateNiyet(NiyetlerCompanion entry) =>
      update(niyetler).replace(entry);

  Future<int> deleteNiyet(String id) =>
      (delete(niyetler)..where((t) => t.id.equals(id))).go();

  Future<List<NiyetlerData>> getNiyetlerInRange(DateTime start, DateTime end) {
    return (select(niyetler)
          ..where((t) =>
              t.date.isBiggerOrEqualValue(start) &
              t.date.isSmallerThanValue(end)))
        .get();
  }

  Stream<List<NiyetlerData>> watchTodayNiyetler() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    return (select(niyetler)
          ..where((t) =>
              t.date.isBiggerOrEqualValue(startOfDay) &
              t.date.isSmallerThanValue(endOfDay)))
        .watch();
  }

  // Template CRUD operations
  Future<List<NiyetTemplate>> getTemplates() => select(niyetTemplates).get();

  Stream<List<NiyetTemplate>> watchTemplates() => select(niyetTemplates).watch();

  Future<int> insertTemplate(NiyetTemplatesCompanion entry) =>
      into(niyetTemplates).insert(entry);

  Future<int> deleteTemplate(String id) =>
      (delete(niyetTemplates)..where((t) => t.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'niyet.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
