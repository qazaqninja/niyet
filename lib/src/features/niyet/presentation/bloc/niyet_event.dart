part of 'niyet_bloc.dart';

abstract class NiyetEvent extends Equatable {
  const NiyetEvent();

  @override
  List<Object?> get props => [];
}

class NiyetLoadRequested extends NiyetEvent {
  const NiyetLoadRequested();
}

class NiyetCreated extends NiyetEvent {
  const NiyetCreated({
    required this.text,
    required this.category,
    this.forAllah = true,
  });

  final String text;
  final NiyetCategory category;
  final bool forAllah;

  @override
  List<Object?> get props => [text, category, forAllah];
}

class NiyetOutcomeUpdated extends NiyetEvent {
  const NiyetOutcomeUpdated({
    required this.id,
    required this.outcome,
    this.reflection,
  });

  final String id;
  final NiyetOutcome outcome;
  final String? reflection;

  @override
  List<Object?> get props => [id, outcome, reflection];
}

class NiyetDeleted extends NiyetEvent {
  const NiyetDeleted({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}
