part of 'template_bloc.dart';

enum TemplateStatus { initial, loading, success, failure }

class TemplateState extends Equatable {
  const TemplateState({
    this.status = TemplateStatus.initial,
    this.userTemplates = const [],
    this.error,
    this.lastSavedTemplate,
  });

  final TemplateStatus status;
  final List<NiyetTemplate> userTemplates;
  final String? error;
  final NiyetTemplate? lastSavedTemplate;

  bool get isLoading => status == TemplateStatus.loading;
  bool get hasError => status == TemplateStatus.failure;

  TemplateState copyWith({
    TemplateStatus? status,
    List<NiyetTemplate>? userTemplates,
    String? error,
    NiyetTemplate? lastSavedTemplate,
  }) {
    return TemplateState(
      status: status ?? this.status,
      userTemplates: userTemplates ?? this.userTemplates,
      error: error,
      lastSavedTemplate: lastSavedTemplate,
    );
  }

  @override
  List<Object?> get props => [status, userTemplates, error, lastSavedTemplate];
}
