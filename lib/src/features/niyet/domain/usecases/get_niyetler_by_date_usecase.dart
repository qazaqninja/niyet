import 'package:injectable/injectable.dart';

import '../../../../core/base/base_usecase/result.dart';
import '../../../../core/base/base_usecase/use_case.dart';
import '../entities/niyet.dart';
import '../repositories/niyet_repository.dart';

@injectable
class GetNiyetlerByDateUseCase implements UseCase<List<Niyet>, DateTime> {
  GetNiyetlerByDateUseCase(this._repository);

  final NiyetRepository _repository;

  @override
  Future<Result<List<Niyet>>> call(DateTime params) {
    return _repository.getNiyetlerByDate(params);
  }
}
