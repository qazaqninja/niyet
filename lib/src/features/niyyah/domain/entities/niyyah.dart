import 'package:equatable/equatable.dart';

import 'niyyah_category.dart';
import 'niyyah_outcome.dart';

class Niyyah extends Equatable {
  const Niyyah({
    required this.id,
    required this.date,
    required this.text,
    required this.category,
    this.outcome,
    this.reflection,
    this.forAllah = true,
    required this.createdAt,
    this.updatedAt,
  });

  final String id;
  final DateTime date;
  final String text;
  final NiyyahCategory category;
  final NiyyahOutcome? outcome;
  final String? reflection;
  final bool forAllah;
  final DateTime createdAt;
  final DateTime? updatedAt;

  bool get isReflected => outcome != null;

  Niyyah copyWith({
    String? id,
    DateTime? date,
    String? text,
    NiyyahCategory? category,
    NiyyahOutcome? outcome,
    String? reflection,
    bool? forAllah,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Niyyah(
      id: id ?? this.id,
      date: date ?? this.date,
      text: text ?? this.text,
      category: category ?? this.category,
      outcome: outcome ?? this.outcome,
      reflection: reflection ?? this.reflection,
      forAllah: forAllah ?? this.forAllah,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        date,
        text,
        category,
        outcome,
        reflection,
        forAllah,
        createdAt,
        updatedAt,
      ];
}
