import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/base_usecase/use_case.dart';
import '../../domain/entities/niyet_category.dart';
import '../../domain/entities/niyet_template.dart';
import '../../domain/repositories/niyet_template_repository.dart';
import '../../domain/usecases/create_template_usecase.dart';
import '../../domain/usecases/get_templates_usecase.dart';

part 'template_event.dart';
part 'template_state.dart';

@injectable
class TemplateBloc extends Bloc<TemplateEvent, TemplateState> {
  TemplateBloc({
    required GetTemplatesUseCase getTemplates,
    required CreateTemplateUseCase createTemplate,
    required NiyetTemplateRepository repository,
  })  : _getTemplates = getTemplates,
        _createTemplate = createTemplate,
        _repository = repository,
        super(const TemplateState()) {
    on<TemplateLoadRequested>(_onLoadRequested);
    on<TemplateCreated>(_onCreated);

    // Subscribe to real-time updates (matches NiyetBloc pattern)
    _subscription = _repository.watchTemplates().listen(
      (templates) {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(state.copyWith(
          status: TemplateStatus.success,
          userTemplates: templates,
        ));
      },
      onError: (error) {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(state.copyWith(
          status: TemplateStatus.failure,
          error: error.toString(),
        ));
      },
    );
  }

  final GetTemplatesUseCase _getTemplates;
  final CreateTemplateUseCase _createTemplate;
  final NiyetTemplateRepository _repository;

  StreamSubscription<List<NiyetTemplate>>? _subscription;

  Future<void> _onLoadRequested(
    TemplateLoadRequested event,
    Emitter<TemplateState> emit,
  ) async {
    emit(state.copyWith(status: TemplateStatus.loading));

    final result = await _getTemplates(const NoParams());
    result.when(
      success: (templates) => emit(state.copyWith(
        status: TemplateStatus.success,
        userTemplates: templates,
      )),
      failure: (e) => emit(
        state.copyWith(status: TemplateStatus.failure, error: e.toString()),
      ),
    );
  }

  Future<void> _onCreated(
    TemplateCreated event,
    Emitter<TemplateState> emit,
  ) async {
    final params = CreateTemplateParams(
      text: event.text,
      category: event.category,
    );

    final result = await _createTemplate(params);
    result.when(
      success: (template) {
        emit(state.copyWith(
          status: TemplateStatus.success,
          userTemplates: [...state.userTemplates, template],
          lastSavedTemplate: template,
        ));
      },
      failure: (e) => emit(
        state.copyWith(status: TemplateStatus.failure, error: e.toString()),
      ),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
