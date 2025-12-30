part of 'niyet_bloc.dart';

enum NiyetStatus { initial, loading, success, failure }

class NiyetState extends Equatable {
  const NiyetState({
    this.status = NiyetStatus.initial,
    this.niyetler = const [],
    this.error,
  });

  final NiyetStatus status;
  final List<Niyet> niyetler;
  final String? error;

  bool get isLoading => status == NiyetStatus.loading;
  bool get hasError => status == NiyetStatus.failure;
  bool get isEmpty => niyetler.isEmpty && status == NiyetStatus.success;

  int get todayCount => niyetler.length;
  int get reflectedCount => niyetler.where((n) => n.isReflected).length;
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
