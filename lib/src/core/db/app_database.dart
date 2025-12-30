import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// Niyyat table (plural of niyyah in Arabic)
class Niyyat extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get niyyahText => text()();
  IntColumn get category => integer()();
  IntColumn get outcome => integer().nullable()();
  TextColumn get reflection => text().nullable()();
  BoolColumn get forAllah => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Niyyat])
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
  int get schemaVersion => 1;

  // Niyyah CRUD operations
  Future<List<NiyyatData>> getNiyyatByDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    return (select(niyyat)
          ..where((t) =>
              t.date.isBiggerOrEqualValue(startOfDay) &
              t.date.isSmallerThanValue(endOfDay)))
        .get();
  }

  Future<List<NiyyatData>> getTodayNiyyat() => getNiyyatByDate(DateTime.now());

  Future<int> insertNiyyah(NiyyatCompanion entry) => into(niyyat).insert(entry);

  Future<bool> updateNiyyah(NiyyatCompanion entry) =>
      update(niyyat).replace(entry);

  Future<int> deleteNiyyah(String id) =>
      (delete(niyyat)..where((t) => t.id.equals(id))).go();

  Future<List<NiyyatData>> getNiyyatInRange(DateTime start, DateTime end) {
    return (select(niyyat)
          ..where((t) =>
              t.date.isBiggerOrEqualValue(start) &
              t.date.isSmallerThanValue(end)))
        .get();
  }

  Stream<List<NiyyatData>> watchTodayNiyyat() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    return (select(niyyat)
          ..where((t) =>
              t.date.isBiggerOrEqualValue(startOfDay) &
              t.date.isSmallerThanValue(endOfDay)))
        .watch();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'niyet.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
