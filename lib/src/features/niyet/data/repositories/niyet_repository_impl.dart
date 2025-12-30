import 'package:injectable/injectable.dart';

import '../../../../core/base/base_usecase/result.dart';
import '../../domain/entities/niyet.dart';
import '../../domain/entities/niyet_outcome.dart';
import '../../domain/repositories/niyet_repository.dart';
import '../datasources/niyet_local_datasource.dart';

@LazySingleton(as: NiyetRepository)
class NiyetRepositoryImpl implements NiyetRepository {
  NiyetRepositoryImpl(this._localDataSource);

  final NiyetLocalDataSource _localDataSource;

  @override
  Future<Result<List<Niyet>>> getTodayNiyetler() async {
    try {
      final niyetler = await _localDataSource.getTodayNiyetler();
      return Result.success(niyetler);
    } catch (e) {
      return Result.failure(Exception('Failed to get today\'s niyetler: $e'));
    }
  }

  @override
  Future<Result<List<Niyet>>> getNiyetlerByDate(DateTime date) async {
    try {
      final niyetler = await _localDataSource.getNiyetlerByDate(date);
      return Result.success(niyetler);
    } catch (e) {
      return Result.failure(Exception('Failed to get niyetler by date: $e'));
    }
  }

  @override
  Future<Result<List<Niyet>>> getNiyetlerInRange(
    DateTime start,
    DateTime end,
  ) async {
    try {
      final niyetler = await _localDataSource.getNiyetlerInRange(start, end);
      return Result.success(niyetler);
    } catch (e) {
      return Result.failure(Exception('Failed to get niyetler in range: $e'));
    }
  }

  @override
  Future<Result<Niyet>> createNiyet(Niyet niyet) async {
    try {
      final created = await _localDataSource.insertNiyet(niyet);
      return Result.success(created);
    } catch (e) {
      return Result.failure(Exception('Failed to create niyet: $e'));
    }
  }

  @override
  Future<Result<Niyet>> updateNiyetOutcome(
    String id,
    NiyetOutcome outcome,
    String? reflection,
  ) async {
    try {
      // Get existing niyet
      final niyetler = await _localDataSource.getTodayNiyetler();
      final existing = niyetler.firstWhere(
        (n) => n.id == id,
        orElse: () => throw Exception('Niyet not found'),
      );

      // Update with new outcome
      final updated = existing.copyWith(
        outcome: outcome,
        reflection: reflection,
        updatedAt: DateTime.now(),
      );

      final result = await _localDataSource.updateNiyet(updated);
      return Result.success(result);
    } catch (e) {
      return Result.failure(Exception('Failed to update niyet outcome: $e'));
    }
  }

  @override
  Future<Result<void>> deleteNiyet(String id) async {
    try {
      await _localDataSource.deleteNiyet(id);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(Exception('Failed to delete niyet: $e'));
    }
  }

  @override
  Stream<List<Niyet>> watchTodayNiyetler() {
    return _localDataSource.watchTodayNiyetler();
  }
}
