import '../../../../core/base/base_usecase/result.dart';
import '../entities/niyet.dart';
import '../entities/niyet_outcome.dart';

abstract class NiyetRepository {
  Future<Result<List<Niyet>>> getTodayNiyetler();
  Future<Result<List<Niyet>>> getNiyetlerByDate(DateTime date);
  Future<Result<List<Niyet>>> getNiyetlerInRange(DateTime start, DateTime end);
  Future<Result<Niyet>> createNiyet(Niyet niyet);
  Future<Result<Niyet>> updateNiyetOutcome(
    String id,
    NiyetOutcome outcome,
    String? reflection,
  );
  Future<Result<void>> deleteNiyet(String id);
  Stream<List<Niyet>> watchTodayNiyetler();
}
