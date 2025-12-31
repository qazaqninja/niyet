// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $NiyetlerTable extends Niyetler
    with TableInfo<$NiyetlerTable, NiyetlerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NiyetlerTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _niyetTextMeta = const VerificationMeta(
    'niyetText',
  );
  @override
  late final GeneratedColumn<String> niyetText = GeneratedColumn<String>(
    'niyet_text',
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
    niyetText,
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
  static const String $name = 'niyetler';
  @override
  VerificationContext validateIntegrity(
    Insertable<NiyetlerData> instance, {
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
    if (data.containsKey('niyet_text')) {
      context.handle(
        _niyetTextMeta,
        niyetText.isAcceptableOrUnknown(data['niyet_text']!, _niyetTextMeta),
      );
    } else if (isInserting) {
      context.missing(_niyetTextMeta);
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
  NiyetlerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NiyetlerData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      niyetText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}niyet_text'],
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
  $NiyetlerTable createAlias(String alias) {
    return $NiyetlerTable(attachedDatabase, alias);
  }
}

class NiyetlerData extends DataClass implements Insertable<NiyetlerData> {
  final String id;
  final DateTime date;
  final String niyetText;
  final int category;
  final int? outcome;
  final String? reflection;
  final bool forAllah;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const NiyetlerData({
    required this.id,
    required this.date,
    required this.niyetText,
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
    map['niyet_text'] = Variable<String>(niyetText);
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

  NiyetlerCompanion toCompanion(bool nullToAbsent) {
    return NiyetlerCompanion(
      id: Value(id),
      date: Value(date),
      niyetText: Value(niyetText),
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

  factory NiyetlerData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NiyetlerData(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      niyetText: serializer.fromJson<String>(json['niyetText']),
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
      'niyetText': serializer.toJson<String>(niyetText),
      'category': serializer.toJson<int>(category),
      'outcome': serializer.toJson<int?>(outcome),
      'reflection': serializer.toJson<String?>(reflection),
      'forAllah': serializer.toJson<bool>(forAllah),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  NiyetlerData copyWith({
    String? id,
    DateTime? date,
    String? niyetText,
    int? category,
    Value<int?> outcome = const Value.absent(),
    Value<String?> reflection = const Value.absent(),
    bool? forAllah,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => NiyetlerData(
    id: id ?? this.id,
    date: date ?? this.date,
    niyetText: niyetText ?? this.niyetText,
    category: category ?? this.category,
    outcome: outcome.present ? outcome.value : this.outcome,
    reflection: reflection.present ? reflection.value : this.reflection,
    forAllah: forAllah ?? this.forAllah,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  NiyetlerData copyWithCompanion(NiyetlerCompanion data) {
    return NiyetlerData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      niyetText: data.niyetText.present ? data.niyetText.value : this.niyetText,
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
    return (StringBuffer('NiyetlerData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('niyetText: $niyetText, ')
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
    niyetText,
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
      (other is NiyetlerData &&
          other.id == this.id &&
          other.date == this.date &&
          other.niyetText == this.niyetText &&
          other.category == this.category &&
          other.outcome == this.outcome &&
          other.reflection == this.reflection &&
          other.forAllah == this.forAllah &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class NiyetlerCompanion extends UpdateCompanion<NiyetlerData> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<String> niyetText;
  final Value<int> category;
  final Value<int?> outcome;
  final Value<String?> reflection;
  final Value<bool> forAllah;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const NiyetlerCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.niyetText = const Value.absent(),
    this.category = const Value.absent(),
    this.outcome = const Value.absent(),
    this.reflection = const Value.absent(),
    this.forAllah = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NiyetlerCompanion.insert({
    required String id,
    required DateTime date,
    required String niyetText,
    required int category,
    this.outcome = const Value.absent(),
    this.reflection = const Value.absent(),
    this.forAllah = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       niyetText = Value(niyetText),
       category = Value(category),
       createdAt = Value(createdAt);
  static Insertable<NiyetlerData> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<String>? niyetText,
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
      if (niyetText != null) 'niyet_text': niyetText,
      if (category != null) 'category': category,
      if (outcome != null) 'outcome': outcome,
      if (reflection != null) 'reflection': reflection,
      if (forAllah != null) 'for_allah': forAllah,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NiyetlerCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<String>? niyetText,
    Value<int>? category,
    Value<int?>? outcome,
    Value<String?>? reflection,
    Value<bool>? forAllah,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return NiyetlerCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      niyetText: niyetText ?? this.niyetText,
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
    if (niyetText.present) {
      map['niyet_text'] = Variable<String>(niyetText.value);
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
    return (StringBuffer('NiyetlerCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('niyetText: $niyetText, ')
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

class $NiyetTemplatesTable extends NiyetTemplates
    with TableInfo<$NiyetTemplatesTable, NiyetTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NiyetTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _templateTextMeta = const VerificationMeta(
    'templateText',
  );
  @override
  late final GeneratedColumn<String> templateText = GeneratedColumn<String>(
    'template_text',
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
  @override
  List<GeneratedColumn> get $columns => [id, templateText, category, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'niyet_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<NiyetTemplate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('template_text')) {
      context.handle(
        _templateTextMeta,
        templateText.isAcceptableOrUnknown(
          data['template_text']!,
          _templateTextMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_templateTextMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NiyetTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NiyetTemplate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      templateText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_text'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $NiyetTemplatesTable createAlias(String alias) {
    return $NiyetTemplatesTable(attachedDatabase, alias);
  }
}

class NiyetTemplate extends DataClass implements Insertable<NiyetTemplate> {
  final String id;
  final String templateText;
  final int category;
  final DateTime createdAt;
  const NiyetTemplate({
    required this.id,
    required this.templateText,
    required this.category,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['template_text'] = Variable<String>(templateText);
    map['category'] = Variable<int>(category);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  NiyetTemplatesCompanion toCompanion(bool nullToAbsent) {
    return NiyetTemplatesCompanion(
      id: Value(id),
      templateText: Value(templateText),
      category: Value(category),
      createdAt: Value(createdAt),
    );
  }

  factory NiyetTemplate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NiyetTemplate(
      id: serializer.fromJson<String>(json['id']),
      templateText: serializer.fromJson<String>(json['templateText']),
      category: serializer.fromJson<int>(json['category']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'templateText': serializer.toJson<String>(templateText),
      'category': serializer.toJson<int>(category),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  NiyetTemplate copyWith({
    String? id,
    String? templateText,
    int? category,
    DateTime? createdAt,
  }) => NiyetTemplate(
    id: id ?? this.id,
    templateText: templateText ?? this.templateText,
    category: category ?? this.category,
    createdAt: createdAt ?? this.createdAt,
  );
  NiyetTemplate copyWithCompanion(NiyetTemplatesCompanion data) {
    return NiyetTemplate(
      id: data.id.present ? data.id.value : this.id,
      templateText: data.templateText.present
          ? data.templateText.value
          : this.templateText,
      category: data.category.present ? data.category.value : this.category,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NiyetTemplate(')
          ..write('id: $id, ')
          ..write('templateText: $templateText, ')
          ..write('category: $category, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, templateText, category, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NiyetTemplate &&
          other.id == this.id &&
          other.templateText == this.templateText &&
          other.category == this.category &&
          other.createdAt == this.createdAt);
}

class NiyetTemplatesCompanion extends UpdateCompanion<NiyetTemplate> {
  final Value<String> id;
  final Value<String> templateText;
  final Value<int> category;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const NiyetTemplatesCompanion({
    this.id = const Value.absent(),
    this.templateText = const Value.absent(),
    this.category = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NiyetTemplatesCompanion.insert({
    required String id,
    required String templateText,
    required int category,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       templateText = Value(templateText),
       category = Value(category),
       createdAt = Value(createdAt);
  static Insertable<NiyetTemplate> custom({
    Expression<String>? id,
    Expression<String>? templateText,
    Expression<int>? category,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (templateText != null) 'template_text': templateText,
      if (category != null) 'category': category,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NiyetTemplatesCompanion copyWith({
    Value<String>? id,
    Value<String>? templateText,
    Value<int>? category,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return NiyetTemplatesCompanion(
      id: id ?? this.id,
      templateText: templateText ?? this.templateText,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (templateText.present) {
      map['template_text'] = Variable<String>(templateText.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(category.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NiyetTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('templateText: $templateText, ')
          ..write('category: $category, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NiyetlerTable niyetler = $NiyetlerTable(this);
  late final $NiyetTemplatesTable niyetTemplates = $NiyetTemplatesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    niyetler,
    niyetTemplates,
  ];
}

typedef $$NiyetlerTableCreateCompanionBuilder =
    NiyetlerCompanion Function({
      required String id,
      required DateTime date,
      required String niyetText,
      required int category,
      Value<int?> outcome,
      Value<String?> reflection,
      Value<bool> forAllah,
      required DateTime createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$NiyetlerTableUpdateCompanionBuilder =
    NiyetlerCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<String> niyetText,
      Value<int> category,
      Value<int?> outcome,
      Value<String?> reflection,
      Value<bool> forAllah,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$NiyetlerTableFilterComposer
    extends Composer<_$AppDatabase, $NiyetlerTable> {
  $$NiyetlerTableFilterComposer({
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

  ColumnFilters<String> get niyetText => $composableBuilder(
    column: $table.niyetText,
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

class $$NiyetlerTableOrderingComposer
    extends Composer<_$AppDatabase, $NiyetlerTable> {
  $$NiyetlerTableOrderingComposer({
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

  ColumnOrderings<String> get niyetText => $composableBuilder(
    column: $table.niyetText,
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

class $$NiyetlerTableAnnotationComposer
    extends Composer<_$AppDatabase, $NiyetlerTable> {
  $$NiyetlerTableAnnotationComposer({
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

  GeneratedColumn<String> get niyetText =>
      $composableBuilder(column: $table.niyetText, builder: (column) => column);

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

class $$NiyetlerTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NiyetlerTable,
          NiyetlerData,
          $$NiyetlerTableFilterComposer,
          $$NiyetlerTableOrderingComposer,
          $$NiyetlerTableAnnotationComposer,
          $$NiyetlerTableCreateCompanionBuilder,
          $$NiyetlerTableUpdateCompanionBuilder,
          (
            NiyetlerData,
            BaseReferences<_$AppDatabase, $NiyetlerTable, NiyetlerData>,
          ),
          NiyetlerData,
          PrefetchHooks Function()
        > {
  $$NiyetlerTableTableManager(_$AppDatabase db, $NiyetlerTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NiyetlerTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NiyetlerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NiyetlerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> niyetText = const Value.absent(),
                Value<int> category = const Value.absent(),
                Value<int?> outcome = const Value.absent(),
                Value<String?> reflection = const Value.absent(),
                Value<bool> forAllah = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NiyetlerCompanion(
                id: id,
                date: date,
                niyetText: niyetText,
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
                required String niyetText,
                required int category,
                Value<int?> outcome = const Value.absent(),
                Value<String?> reflection = const Value.absent(),
                Value<bool> forAllah = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NiyetlerCompanion.insert(
                id: id,
                date: date,
                niyetText: niyetText,
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

typedef $$NiyetlerTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NiyetlerTable,
      NiyetlerData,
      $$NiyetlerTableFilterComposer,
      $$NiyetlerTableOrderingComposer,
      $$NiyetlerTableAnnotationComposer,
      $$NiyetlerTableCreateCompanionBuilder,
      $$NiyetlerTableUpdateCompanionBuilder,
      (
        NiyetlerData,
        BaseReferences<_$AppDatabase, $NiyetlerTable, NiyetlerData>,
      ),
      NiyetlerData,
      PrefetchHooks Function()
    >;
typedef $$NiyetTemplatesTableCreateCompanionBuilder =
    NiyetTemplatesCompanion Function({
      required String id,
      required String templateText,
      required int category,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$NiyetTemplatesTableUpdateCompanionBuilder =
    NiyetTemplatesCompanion Function({
      Value<String> id,
      Value<String> templateText,
      Value<int> category,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$NiyetTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $NiyetTemplatesTable> {
  $$NiyetTemplatesTableFilterComposer({
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

  ColumnFilters<String> get templateText => $composableBuilder(
    column: $table.templateText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NiyetTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $NiyetTemplatesTable> {
  $$NiyetTemplatesTableOrderingComposer({
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

  ColumnOrderings<String> get templateText => $composableBuilder(
    column: $table.templateText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NiyetTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NiyetTemplatesTable> {
  $$NiyetTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get templateText => $composableBuilder(
    column: $table.templateText,
    builder: (column) => column,
  );

  GeneratedColumn<int> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$NiyetTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NiyetTemplatesTable,
          NiyetTemplate,
          $$NiyetTemplatesTableFilterComposer,
          $$NiyetTemplatesTableOrderingComposer,
          $$NiyetTemplatesTableAnnotationComposer,
          $$NiyetTemplatesTableCreateCompanionBuilder,
          $$NiyetTemplatesTableUpdateCompanionBuilder,
          (
            NiyetTemplate,
            BaseReferences<_$AppDatabase, $NiyetTemplatesTable, NiyetTemplate>,
          ),
          NiyetTemplate,
          PrefetchHooks Function()
        > {
  $$NiyetTemplatesTableTableManager(
    _$AppDatabase db,
    $NiyetTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NiyetTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NiyetTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NiyetTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> templateText = const Value.absent(),
                Value<int> category = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NiyetTemplatesCompanion(
                id: id,
                templateText: templateText,
                category: category,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String templateText,
                required int category,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => NiyetTemplatesCompanion.insert(
                id: id,
                templateText: templateText,
                category: category,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NiyetTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NiyetTemplatesTable,
      NiyetTemplate,
      $$NiyetTemplatesTableFilterComposer,
      $$NiyetTemplatesTableOrderingComposer,
      $$NiyetTemplatesTableAnnotationComposer,
      $$NiyetTemplatesTableCreateCompanionBuilder,
      $$NiyetTemplatesTableUpdateCompanionBuilder,
      (
        NiyetTemplate,
        BaseReferences<_$AppDatabase, $NiyetTemplatesTable, NiyetTemplate>,
      ),
      NiyetTemplate,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NiyetlerTableTableManager get niyetler =>
      $$NiyetlerTableTableManager(_db, _db.niyetler);
  $$NiyetTemplatesTableTableManager get niyetTemplates =>
      $$NiyetTemplatesTableTableManager(_db, _db.niyetTemplates);
}
