part of 'niyyah_bloc.dart';

enum NiyyahStatus { initial, loading, success, failure }

class NiyyahState extends Equatable {
  const NiyyahState({
    this.status = NiyyahStatus.initial,
    this.niyyat = const [],
    this.error,
  });

  final NiyyahStatus status;
  final List<Niyyah> niyyat;
  final String? error;

  bool get isLoading => status == NiyyahStatus.loading;
  bool get hasError => status == NiyyahStatus.failure;
  bool get isEmpty => niyyat.isEmpty && status == NiyyahStatus.success;

  int get todayCount => niyyat.length;
  int get reflectedCount => niyyat.where((n) => n.isReflected).length;
  bool get allReflected => todayCount > 0 && reflectedCount == todayCount;

  NiyyahState copyWith({
    NiyyahStatus? status,
    List<Niyyah>? niyyat,
    String? error,
  }) {
    return NiyyahState(
      status: status ?? this.status,
      niyyat: niyyat ?? this.niyyat,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, niyyat, error];
}
