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
