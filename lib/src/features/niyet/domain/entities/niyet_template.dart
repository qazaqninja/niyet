import 'package:equatable/equatable.dart';

import 'niyet_category.dart';

class NiyetTemplate extends Equatable {
  const NiyetTemplate({
    required this.id,
    required this.text,
    required this.category,
    this.isDefault = false,
    this.createdAt,
  });

  final String id;
  final String text;
  final NiyetCategory category;
  final bool isDefault;
  final DateTime? createdAt;

  NiyetTemplate copyWith({
    String? id,
    String? text,
    NiyetCategory? category,
    bool? isDefault,
    DateTime? createdAt,
  }) {
    return NiyetTemplate(
      id: id ?? this.id,
      text: text ?? this.text,
      category: category ?? this.category,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, text, category, isDefault, createdAt];
}
