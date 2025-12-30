import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/preferences/preferences_service.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

@injectable
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc({
    required PreferencesService preferencesService,
  })  : _preferencesService = preferencesService,
        super(const OnboardingState()) {
    on<OnboardingPageChanged>(_onPageChanged);
    on<OnboardingCompleted>(_onCompleted);
    on<OnboardingSkipped>(_onSkipped);
  }

  final PreferencesService _preferencesService;

  static const int totalPages = 5;

  void _onPageChanged(
    OnboardingPageChanged event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(currentPage: event.page));
  }

  Future<void> _onCompleted(
    OnboardingCompleted event,
    Emitter<OnboardingState> emit,
  ) async {
    await _preferencesService.setOnboardingCompleted();
    emit(state.copyWith(isCompleted: true));
  }

  Future<void> _onSkipped(
    OnboardingSkipped event,
    Emitter<OnboardingState> emit,
  ) async {
    await _preferencesService.setOnboardingCompleted();
    emit(state.copyWith(isCompleted: true));
  }
}
