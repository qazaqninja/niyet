import 'package:injectable/injectable.dart';

import '../../../../core/base/base_usecase/result.dart';
import '../../domain/entities/niyyah.dart';
import '../../domain/entities/niyyah_outcome.dart';
import '../../domain/repositories/niyyah_repository.dart';
import '../datasources/niyyah_local_datasource.dart';

@LazySingleton(as: NiyyahRepository)
class NiyyahRepositoryImpl implements NiyyahRepository {
  NiyyahRepositoryImpl(this._localDataSource);

  final NiyyahLocalDataSource _localDataSource;

  @override
  Future<Result<List<Niyyah>>> getTodayNiyyat() async {
    try {
      final niyyat = await _localDataSource.getTodayNiyyat();
      return Result.success(niyyat);
    } catch (e) {
      return Result.failure(Exception('Failed to get today\'s niyyat: $e'));
    }
  }

  @override
  Future<Result<List<Niyyah>>> getNiyyatByDate(DateTime date) async {
    try {
      final niyyat = await _localDataSource.getNiyyatByDate(date);
      return Result.success(niyyat);
    } catch (e) {
      return Result.failure(Exception('Failed to get niyyat by date: $e'));
    }
  }

  @override
  Future<Result<List<Niyyah>>> getNiyyatInRange(
    DateTime start,
    DateTime end,
  ) async {
    try {
      final niyyat = await _localDataSource.getNiyyatInRange(start, end);
      return Result.success(niyyat);
    } catch (e) {
      return Result.failure(Exception('Failed to get niyyat in range: $e'));
    }
  }

  @override
  Future<Result<Niyyah>> createNiyyah(Niyyah niyyah) async {
    try {
      final created = await _localDataSource.insertNiyyah(niyyah);
      return Result.success(created);
    } catch (e) {
      return Result.failure(Exception('Failed to create niyyah: $e'));
    }
  }

  @override
  Future<Result<Niyyah>> updateNiyyahOutcome(
    String id,
    NiyyahOutcome outcome,
    String? reflection,
  ) async {
    try {
      // Get existing niyyah
      final niyyat = await _localDataSource.getTodayNiyyat();
      final existing = niyyat.firstWhere(
        (n) => n.id == id,
        orElse: () => throw Exception('Niyyah not found'),
      );

      // Update with new outcome
      final updated = existing.copyWith(
        outcome: outcome,
        reflection: reflection,
        updatedAt: DateTime.now(),
      );

      final result = await _localDataSource.updateNiyyah(updated);
      return Result.success(result);
    } catch (e) {
      return Result.failure(Exception('Failed to update niyyah outcome: $e'));
    }
  }

  @override
  Future<Result<void>> deleteNiyyah(String id) async {
    try {
      await _localDataSource.deleteNiyyah(id);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(Exception('Failed to delete niyyah: $e'));
    }
  }

  @override
  Stream<List<Niyyah>> watchTodayNiyyat() {
    return _localDataSource.watchTodayNiyyat();
  }
}
