import '../../../../core/base/base_usecase/result.dart';
import '../entities/niyyah.dart';
import '../entities/niyyah_outcome.dart';

abstract class NiyyahRepository {
  Future<Result<List<Niyyah>>> getTodayNiyyat();
  Future<Result<List<Niyyah>>> getNiyyatByDate(DateTime date);
  Future<Result<List<Niyyah>>> getNiyyatInRange(DateTime start, DateTime end);
  Future<Result<Niyyah>> createNiyyah(Niyyah niyyah);
  Future<Result<Niyyah>> updateNiyyahOutcome(
    String id,
    NiyyahOutcome outcome,
    String? reflection,
  );
  Future<Result<void>> deleteNiyyah(String id);
  Stream<List<Niyyah>> watchTodayNiyyat();
}
