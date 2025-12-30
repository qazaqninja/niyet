part of 'niyet_bloc.dart';

enum NiyetStatus { initial, loading, success, failure }

class NiyetState extends Equatable {
  NiyetState({
    this.status = NiyetStatus.initial,
    this.niyetler = const [],
    this.error,
  }) : reflectedCount = niyetler.where((n) => n.isReflected).length,
       unreflectedCount = niyetler.where((n) => !n.isReflected).length;

  final NiyetStatus status;
  final List<Niyet> niyetler;
  final String? error;

  // Cached computed values
  final int reflectedCount;
  final int unreflectedCount;

  bool get isLoading => status == NiyetStatus.loading;
  bool get hasError => status == NiyetStatus.failure;
  bool get isEmpty => niyetler.isEmpty && status == NiyetStatus.success;

  int get todayCount => niyetler.length;
  bool get allReflected => todayCount > 0 && reflectedCount == todayCount;

  NiyetState copyWith({
    NiyetStatus? status,
    List<Niyet>? niyetler,
    String? error,
  }) {
    return NiyetState(
      status: status ?? this.status,
      niyetler: niyetler ?? this.niyetler,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, niyetler, error];
}
