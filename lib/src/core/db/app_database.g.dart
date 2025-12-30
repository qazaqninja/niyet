// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $NiyyatTable extends Niyyat with TableInfo<$NiyyatTable, NiyyatData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NiyyatTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _niyyahTextMeta = const VerificationMeta(
    'niyyahText',
  );
  @override
  late final GeneratedColumn<String> niyyahText = GeneratedColumn<String>(
    'niyyah_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<int> category = GeneratedColumn<int>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _outcomeMeta = const VerificationMeta(
    'outcome',
  );
  @override
  late final GeneratedColumn<int> outcome = GeneratedColumn<int>(
    'outcome',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reflectionMeta = const VerificationMeta(
    'reflection',
  );
  @override
  late final GeneratedColumn<String> reflection = GeneratedColumn<String>(
    'reflection',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _forAllahMeta = const VerificationMeta(
    'forAllah',
  );
  @override
  late final GeneratedColumn<bool> forAllah = GeneratedColumn<bool>(
    'for_allah',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("for_allah" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    niyyahText,
    category,
    outcome,
    reflection,
    forAllah,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'niyyat';
  @override
  VerificationContext validateIntegrity(
    Insertable<NiyyatData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('niyyah_text')) {
      context.handle(
        _niyyahTextMeta,
        niyyahText.isAcceptableOrUnknown(data['niyyah_text']!, _niyyahTextMeta),
      );
    } else if (isInserting) {
      context.missing(_niyyahTextMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('outcome')) {
      context.handle(
        _outcomeMeta,
        outcome.isAcceptableOrUnknown(data['outcome']!, _outcomeMeta),
      );
    }
    if (data.containsKey('reflection')) {
      context.handle(
        _reflectionMeta,
        reflection.isAcceptableOrUnknown(data['reflection']!, _reflectionMeta),
      );
    }
    if (data.containsKey('for_allah')) {
      context.handle(
        _forAllahMeta,
        forAllah.isAcceptableOrUnknown(data['for_allah']!, _forAllahMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NiyyatData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NiyyatData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      niyyahText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}niyyah_text'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category'],
      )!,
      outcome: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}outcome'],
      ),
      reflection: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reflection'],
      ),
      forAllah: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}for_allah'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $NiyyatTable createAlias(String alias) {
    return $NiyyatTable(attachedDatabase, alias);
  }
}

class NiyyatData extends DataClass implements Insertable<NiyyatData> {
  final String id;
  final DateTime date;
  final String niyyahText;
  final int category;
  final int? outcome;
  final String? reflection;
  final bool forAllah;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const NiyyatData({
    required this.id,
    required this.date,
    required this.niyyahText,
    required this.category,
    this.outcome,
    this.reflection,
    required this.forAllah,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['niyyah_text'] = Variable<String>(niyyahText);
    map['category'] = Variable<int>(category);
    if (!nullToAbsent || outcome != null) {
      map['outcome'] = Variable<int>(outcome);
    }
    if (!nullToAbsent || reflection != null) {
      map['reflection'] = Variable<String>(reflection);
    }
    map['for_allah'] = Variable<bool>(forAllah);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  NiyyatCompanion toCompanion(bool nullToAbsent) {
    return NiyyatCompanion(
      id: Value(id),
      date: Value(date),
      niyyahText: Value(niyyahText),
      category: Value(category),
      outcome: outcome == null && nullToAbsent
          ? const Value.absent()
          : Value(outcome),
      reflection: reflection == null && nullToAbsent
          ? const Value.absent()
          : Value(reflection),
      forAllah: Value(forAllah),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory NiyyatData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NiyyatData(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      niyyahText: serializer.fromJson<String>(json['niyyahText']),
      category: serializer.fromJson<int>(json['category']),
      outcome: serializer.fromJson<int?>(json['outcome']),
      reflection: serializer.fromJson<String?>(json['reflection']),
      forAllah: serializer.fromJson<bool>(json['forAllah']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'niyyahText': serializer.toJson<String>(niyyahText),
      'category': serializer.toJson<int>(category),
      'outcome': serializer.toJson<int?>(outcome),
      'reflection': serializer.toJson<String?>(reflection),
      'forAllah': serializer.toJson<bool>(forAllah),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  NiyyatData copyWith({
    String? id,
    DateTime? date,
    String? niyyahText,
    int? category,
    Value<int?> outcome = const Value.absent(),
    Value<String?> reflection = const Value.absent(),
    bool? forAllah,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => NiyyatData(
    id: id ?? this.id,
    date: date ?? this.date,
    niyyahText: niyyahText ?? this.niyyahText,
    category: category ?? this.category,
    outcome: outcome.present ? outcome.value : this.outcome,
    reflection: reflection.present ? reflection.value : this.reflection,
    forAllah: forAllah ?? this.forAllah,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  NiyyatData copyWithCompanion(NiyyatCompanion data) {
    return NiyyatData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      niyyahText: data.niyyahText.present
          ? data.niyyahText.value
          : this.niyyahText,
      category: data.category.present ? data.category.value : this.category,
      outcome: data.outcome.present ? data.outcome.value : this.outcome,
      reflection: data.reflection.present
          ? data.reflection.value
          : this.reflection,
      forAllah: data.forAllah.present ? data.forAllah.value : this.forAllah,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NiyyatData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('niyyahText: $niyyahText, ')
          ..write('category: $category, ')
          ..write('outcome: $outcome, ')
          ..write('reflection: $reflection, ')
          ..write('forAllah: $forAllah, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    niyyahText,
    category,
    outcome,
    reflection,
    forAllah,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NiyyatData &&
          other.id == this.id &&
          other.date == this.date &&
          other.niyyahText == this.niyyahText &&
          other.category == this.category &&
          other.outcome == this.outcome &&
          other.reflection == this.reflection &&
          other.forAllah == this.forAllah &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class NiyyatCompanion extends UpdateCompanion<NiyyatData> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<String> niyyahText;
  final Value<int> category;
  final Value<int?> outcome;
  final Value<String?> reflection;
  final Value<bool> forAllah;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const NiyyatCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.niyyahText = const Value.absent(),
    this.category = const Value.absent(),
    this.outcome = const Value.absent(),
    this.reflection = const Value.absent(),
    this.forAllah = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NiyyatCompanion.insert({
    required String id,
    required DateTime date,
    required String niyyahText,
    required int category,
    this.outcome = const Value.absent(),
    this.reflection = const Value.absent(),
    this.forAllah = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       niyyahText = Value(niyyahText),
       category = Value(category),
       createdAt = Value(createdAt);
  static Insertable<NiyyatData> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<String>? niyyahText,
    Expression<int>? category,
    Expression<int>? outcome,
    Expression<String>? reflection,
    Expression<bool>? forAllah,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (niyyahText != null) 'niyyah_text': niyyahText,
      if (category != null) 'category': category,
      if (outcome != null) 'outcome': outcome,
      if (reflection != null) 'reflection': reflection,
      if (forAllah != null) 'for_allah': forAllah,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NiyyatCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<String>? niyyahText,
    Value<int>? category,
    Value<int?>? outcome,
    Value<String?>? reflection,
    Value<bool>? forAllah,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return NiyyatCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      niyyahText: niyyahText ?? this.niyyahText,
      category: category ?? this.category,
      outcome: outcome ?? this.outcome,
      reflection: reflection ?? this.reflection,
      forAllah: forAllah ?? this.forAllah,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (niyyahText.present) {
      map['niyyah_text'] = Variable<String>(niyyahText.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(category.value);
    }
    if (outcome.present) {
      map['outcome'] = Variable<int>(outcome.value);
    }
    if (reflection.present) {
      map['reflection'] = Variable<String>(reflection.value);
    }
    if (forAllah.present) {
      map['for_allah'] = Variable<bool>(forAllah.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NiyyatCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('niyyahText: $niyyahText, ')
          ..write('category: $category, ')
          ..write('outcome: $outcome, ')
          ..write('reflection: $reflection, ')
          ..write('forAllah: $forAllah, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NiyyatTable niyyat = $NiyyatTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [niyyat];
}

typedef $$NiyyatTableCreateCompanionBuilder =
    NiyyatCompanion Function({
      required String id,
      required DateTime date,
      required String niyyahText,
      required int category,
      Value<int?> outcome,
      Value<String?> reflection,
      Value<bool> forAllah,
      required DateTime createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$NiyyatTableUpdateCompanionBuilder =
    NiyyatCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<String> niyyahText,
      Value<int> category,
      Value<int?> outcome,
      Value<String?> reflection,
      Value<bool> forAllah,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$NiyyatTableFilterComposer
    extends Composer<_$AppDatabase, $NiyyatTable> {
  $$NiyyatTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get niyyahText => $composableBuilder(
    column: $table.niyyahText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reflection => $composableBuilder(
    column: $table.reflection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get forAllah => $composableBuilder(
    column: $table.forAllah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NiyyatTableOrderingComposer
    extends Composer<_$AppDatabase, $NiyyatTable> {
  $$NiyyatTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get niyyahText => $composableBuilder(
    column: $table.niyyahText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reflection => $composableBuilder(
    column: $table.reflection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get forAllah => $composableBuilder(
    column: $table.forAllah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NiyyatTableAnnotationComposer
    extends Composer<_$AppDatabase, $NiyyatTable> {
  $$NiyyatTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get niyyahText => $composableBuilder(
    column: $table.niyyahText,
    builder: (column) => column,
  );

  GeneratedColumn<int> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get outcome =>
      $composableBuilder(column: $table.outcome, builder: (column) => column);

  GeneratedColumn<String> get reflection => $composableBuilder(
    column: $table.reflection,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get forAllah =>
      $composableBuilder(column: $table.forAllah, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NiyyatTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NiyyatTable,
          NiyyatData,
          $$NiyyatTableFilterComposer,
          $$NiyyatTableOrderingComposer,
          $$NiyyatTableAnnotationComposer,
          $$NiyyatTableCreateCompanionBuilder,
          $$NiyyatTableUpdateCompanionBuilder,
          (NiyyatData, BaseReferences<_$AppDatabase, $NiyyatTable, NiyyatData>),
          NiyyatData,
          PrefetchHooks Function()
        > {
  $$NiyyatTableTableManager(_$AppDatabase db, $NiyyatTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NiyyatTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NiyyatTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NiyyatTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> niyyahText = const Value.absent(),
                Value<int> category = const Value.absent(),
                Value<int?> outcome = const Value.absent(),
                Value<String?> reflection = const Value.absent(),
                Value<bool> forAllah = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NiyyatCompanion(
                id: id,
                date: date,
                niyyahText: niyyahText,
                category: category,
                outcome: outcome,
                reflection: reflection,
                forAllah: forAllah,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                required String niyyahText,
                required int category,
                Value<int?> outcome = const Value.absent(),
                Value<String?> reflection = const Value.absent(),
                Value<bool> forAllah = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NiyyatCompanion.insert(
                id: id,
                date: date,
                niyyahText: niyyahText,
                category: category,
                outcome: outcome,
                reflection: reflection,
                forAllah: forAllah,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NiyyatTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NiyyatTable,
      NiyyatData,
      $$NiyyatTableFilterComposer,
      $$NiyyatTableOrderingComposer,
      $$NiyyatTableAnnotationComposer,
      $$NiyyatTableCreateCompanionBuilder,
      $$NiyyatTableUpdateCompanionBuilder,
      (NiyyatData, BaseReferences<_$AppDatabase, $NiyyatTable, NiyyatData>),
      NiyyatData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NiyyatTableTableManager get niyyat =>
      $$NiyyatTableTableManager(_db, _db.niyyat);
}
