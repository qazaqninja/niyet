import 'package:equatable/equatable.dart';

import 'niyet_category.dart';
import 'niyet_outcome.dart';

class Niyet extends Equatable {
  const Niyet({
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
  final NiyetCategory category;
  final NiyetOutcome? outcome;
  final String? reflection;
  final bool forAllah;
  final DateTime createdAt;
  final DateTime? updatedAt;

  bool get isReflected => outcome != null;

  Niyet copyWith({
    String? id,
    DateTime? date,
    String? text,
    NiyetCategory? category,
    NiyetOutcome? outcome,
    String? reflection,
    bool? forAllah,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Niyet(
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
