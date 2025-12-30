import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/base_usecase/use_case.dart';
import '../../domain/entities/niyyah.dart';
import '../../domain/entities/niyyah_category.dart';
import '../../domain/entities/niyyah_outcome.dart';
import '../../domain/repositories/niyyah_repository.dart';
import '../../domain/usecases/create_niyyah_usecase.dart';
import '../../domain/usecases/get_today_niyyat_usecase.dart';
import '../../domain/usecases/update_niyyah_outcome_usecase.dart';

part 'niyyah_event.dart';
part 'niyyah_state.dart';

@injectable
class NiyyahBloc extends Bloc<NiyyahEvent, NiyyahState> {
  NiyyahBloc({
    required GetTodayNiyyatUseCase getTodayNiyyat,
    required CreateNiyyahUseCase createNiyyah,
    required UpdateNiyyahOutcomeUseCase updateNiyyahOutcome,
    required NiyyahRepository repository,
  })  : _getTodayNiyyat = getTodayNiyyat,
        _createNiyyah = createNiyyah,
        _updateNiyyahOutcome = updateNiyyahOutcome,
        _repository = repository,
        super(const NiyyahState()) {
    on<NiyyahLoadRequested>(_onLoadRequested);
    on<NiyyahCreated>(_onCreated);
    on<NiyyahOutcomeUpdated>(_onOutcomeUpdated);
    on<NiyyahDeleted>(_onDeleted);

    // Subscribe to real-time updates
    _subscription = _repository.watchTodayNiyyat().listen((niyyat) {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(state.copyWith(
        status: NiyyahStatus.success,
        niyyat: niyyat,
      ));
    });
  }

  final GetTodayNiyyatUseCase _getTodayNiyyat;
  final CreateNiyyahUseCase _createNiyyah;
  final UpdateNiyyahOutcomeUseCase _updateNiyyahOutcome;
  final NiyyahRepository _repository;

  StreamSubscription<List<Niyyah>>? _subscription;

  Future<void> _onLoadRequested(
    NiyyahLoadRequested event,
    Emitter<NiyyahState> emit,
  ) async {
    emit(state.copyWith(status: NiyyahStatus.loading));

    final result = await _getTodayNiyyat(const NoParams());
    result.when(
      success: (niyyat) => emit(state.copyWith(
        status: NiyyahStatus.success,
        niyyat: niyyat,
      )),
      failure: (e) => emit(state.copyWith(
        status: NiyyahStatus.failure,
        error: e.toString(),
      )),
    );
  }

  Future<void> _onCreated(
    NiyyahCreated event,
    Emitter<NiyyahState> emit,
  ) async {
    final params = CreateNiyyahParams(
      text: event.text,
      category: event.category,
      forAllah: event.forAllah,
    );

    final result = await _createNiyyah(params);
    result.when(
      success: (niyyah) {
        // Stream will update the state
      },
      failure: (e) => emit(state.copyWith(
        status: NiyyahStatus.failure,
        error: e.toString(),
      )),
    );
  }

  Future<void> _onOutcomeUpdated(
    NiyyahOutcomeUpdated event,
    Emitter<NiyyahState> emit,
  ) async {
    final params = UpdateNiyyahOutcomeParams(
      id: event.id,
      outcome: event.outcome,
      reflection: event.reflection,
    );

    final result = await _updateNiyyahOutcome(params);
    result.when(
      success: (niyyah) {
        // Stream will update the state
      },
      failure: (e) => emit(state.copyWith(
        status: NiyyahStatus.failure,
        error: e.toString(),
      )),
    );
  }

  Future<void> _onDeleted(
    NiyyahDeleted event,
    Emitter<NiyyahState> emit,
  ) async {
    final result = await _repository.deleteNiyyah(event.id);
    result.when(
      success: (_) {
        // Stream will update the state
      },
      failure: (e) => emit(state.copyWith(
        status: NiyyahStatus.failure,
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
