import 'package:injectable/injectable.dart';

import '../../../../core/base/base_usecase/result.dart';
import '../../../../core/base/base_usecase/use_case.dart';
import '../../../niyet/domain/entities/niyet.dart';
import '../../../niyet/domain/repositories/niyet_repository.dart';

@injectable
class GetNiyetlerInRangeUseCase
    implements UseCase<List<Niyet>, DateRangeParams> {
  GetNiyetlerInRangeUseCase(this._repository);

  final NiyetRepository _repository;

  @override
  Future<Result<List<Niyet>>> call(DateRangeParams params) {
    return _repository.getNiyetlerInRange(params.start, params.end);
  }
}

class DateRangeParams {
  const DateRangeParams({required this.start, required this.end});

  final DateTime start;
  final DateTime end;
}
