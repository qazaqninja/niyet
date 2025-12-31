part of 'template_bloc.dart';

abstract class TemplateEvent extends Equatable {
  const TemplateEvent();

  @override
  List<Object?> get props => [];
}

class TemplateLoadRequested extends TemplateEvent {
  const TemplateLoadRequested();
}

class TemplateCreated extends TemplateEvent {
  const TemplateCreated({
    required this.text,
    required this.category,
  });

  final String text;
  final NiyetCategory category;

  @override
  List<Object?> get props => [text, category];
}

/// Internal event for stream updates
class _TemplatesUpdated extends TemplateEvent {
  const _TemplatesUpdated(this.templates);

  final List<NiyetTemplate> templates;

  @override
  List<Object?> get props => [templates];
}

/// Internal event for stream errors
class _TemplatesError extends TemplateEvent {
  const _TemplatesError(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
