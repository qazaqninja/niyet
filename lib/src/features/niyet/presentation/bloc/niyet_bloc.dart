import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/base_usecase/use_case.dart';
import '../../domain/entities/niyet.dart';
import '../../domain/entities/niyet_category.dart';
import '../../domain/entities/niyet_outcome.dart';
import '../../domain/repositories/niyet_repository.dart';
import '../../domain/usecases/create_niyet_usecase.dart';
import '../../domain/usecases/get_today_niyetler_usecase.dart';
import '../../domain/usecases/update_niyet_outcome_usecase.dart';

part 'niyet_event.dart';
part 'niyet_state.dart';

@injectable
class NiyetBloc extends Bloc<NiyetEvent, NiyetState> {
  NiyetBloc({
    required GetTodayNiyetlerUseCase getTodayNiyetler,
    required CreateNiyetUseCase createNiyet,
    required UpdateNiyetOutcomeUseCase updateNiyetOutcome,
    required NiyetRepository repository,
  })  : _getTodayNiyetler = getTodayNiyetler,
        _createNiyet = createNiyet,
        _updateNiyetOutcome = updateNiyetOutcome,
        _repository = repository,
        super(const NiyetState()) {
    on<NiyetLoadRequested>(_onLoadRequested);
    on<NiyetCreated>(_onCreated);
    on<NiyetOutcomeUpdated>(_onOutcomeUpdated);
    on<NiyetDeleted>(_onDeleted);

    // Subscribe to real-time updates
    _subscription = _repository.watchTodayNiyetler().listen((niyetler) {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(state.copyWith(
        status: NiyetStatus.success,
        niyetler: niyetler,
      ));
    });
  }

  final GetTodayNiyetlerUseCase _getTodayNiyetler;
  final CreateNiyetUseCase _createNiyet;
  final UpdateNiyetOutcomeUseCase _updateNiyetOutcome;
  final NiyetRepository _repository;

  StreamSubscription<List<Niyet>>? _subscription;

  Future<void> _onLoadRequested(
    NiyetLoadRequested event,
    Emitter<NiyetState> emit,
  ) async {
    emit(state.copyWith(status: NiyetStatus.loading));

    final result = await _getTodayNiyetler(const NoParams());
    result.when(
      success: (niyetler) => emit(state.copyWith(
        status: NiyetStatus.success,
        niyetler: niyetler,
      )),
      failure: (e) => emit(state.copyWith(
        status: NiyetStatus.failure,
        error: e.toString(),
      )),
    );
  }

  Future<void> _onCreated(
    NiyetCreated event,
    Emitter<NiyetState> emit,
  ) async {
    final params = CreateNiyetParams(
      text: event.text,
      category: event.category,
      forAllah: event.forAllah,
    );

    final result = await _createNiyet(params);
    result.when(
      success: (niyet) {
        // Stream will update the state
      },
      failure: (e) => emit(state.copyWith(
        status: NiyetStatus.failure,
        error: e.toString(),
      )),
    );
  }

  Future<void> _onOutcomeUpdated(
    NiyetOutcomeUpdated event,
    Emitter<NiyetState> emit,
  ) async {
    final params = UpdateNiyetOutcomeParams(
      id: event.id,
      outcome: event.outcome,
      reflection: event.reflection,
    );

    final result = await _updateNiyetOutcome(params);
    result.when(
      success: (niyet) {
        // Stream will update the state
      },
      failure: (e) => emit(state.copyWith(
        status: NiyetStatus.failure,
        error: e.toString(),
      )),
    );
  }

  Future<void> _onDeleted(
    NiyetDeleted event,
    Emitter<NiyetState> emit,
  ) async {
    final result = await _repository.deleteNiyet(event.id);
    result.when(
      success: (_) {
        // Stream will update the state
      },
      failure: (e) => emit(state.copyWith(
        status: NiyetStatus.failure,
        error: e.toString(),
      )),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
