import 'package:injectable/injectable.dart';

import '../../../../core/base/base_usecase/result.dart';
import '../../../../core/base/base_usecase/use_case.dart';
import '../entities/niyyah.dart';
import '../entities/niyyah_outcome.dart';
import '../repositories/niyyah_repository.dart';

class UpdateNiyyahOutcomeParams {
  const UpdateNiyyahOutcomeParams({
    required this.id,
    required this.outcome,
    this.reflection,
  });

  final String id;
  final NiyyahOutcome outcome;
  final String? reflection;
}

@injectable
class UpdateNiyyahOutcomeUseCase
    implements UseCase<Niyyah, UpdateNiyyahOutcomeParams> {
  UpdateNiyyahOutcomeUseCase(this._repository);

  final NiyyahRepository _repository;

  @override
  Future<Result<Niyyah>> call(UpdateNiyyahOutcomeParams params) {
    return _repository.updateNiyyahOutcome(
      params.id,
      params.outcome,
      params.reflection,
    );
  }
}
