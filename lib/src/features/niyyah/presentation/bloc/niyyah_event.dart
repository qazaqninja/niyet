part of 'niyyah_bloc.dart';

abstract class NiyyahEvent extends Equatable {
  const NiyyahEvent();

  @override
  List<Object?> get props => [];
}

class NiyyahLoadRequested extends NiyyahEvent {
  const NiyyahLoadRequested();
}

class NiyyahCreated extends NiyyahEvent {
  const NiyyahCreated({
    required this.text,
    required this.category,
    this.forAllah = true,
  });

  final String text;
  final NiyyahCategory category;
  final bool forAllah;

  @override
  List<Object?> get props => [text, category, forAllah];
}

class NiyyahOutcomeUpdated extends NiyyahEvent {
  const NiyyahOutcomeUpdated({
    required this.id,
    required this.outcome,
    this.reflection,
  });

  final String id;
  final NiyyahOutcome outcome;
  final String? reflection;

  @override
  List<Object?> get props => [id, outcome, reflection];
}

class NiyyahDeleted extends NiyyahEvent {
  const NiyyahDeleted({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}
