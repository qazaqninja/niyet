import 'package:injectable/injectable.dart';

import '../../../../core/base/base_usecase/result.dart';
import '../../../../core/base/base_usecase/use_case.dart';
import '../entities/niyet.dart';
import '../entities/niyet_outcome.dart';
import '../repositories/niyet_repository.dart';

class UpdateNiyetOutcomeParams {
  const UpdateNiyetOutcomeParams({
    required this.id,
    required this.outcome,
    this.reflection,
  });

  final String id;
  final NiyetOutcome outcome;
  final String? reflection;
}

@injectable
class UpdateNiyetOutcomeUseCase
    implements UseCase<Niyet, UpdateNiyetOutcomeParams> {
  UpdateNiyetOutcomeUseCase(this._repository);

  final NiyetRepository _repository;

  @override
  Future<Result<Niyet>> call(UpdateNiyetOutcomeParams params) {
    return _repository.updateNiyetOutcome(
      params.id,
      params.outcome,
      params.reflection,
    );
  }
}
