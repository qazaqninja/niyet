import 'package:injectable/injectable.dart';

import '../../../../core/base/base_usecase/result.dart';
import '../../../../core/base/base_usecase/use_case.dart';
import '../entities/niyet.dart';
import '../repositories/niyet_repository.dart';

@injectable
class GetTodayNiyetlerUseCase implements UseCase<List<Niyet>, NoParams> {
  GetTodayNiyetlerUseCase(this._repository);

  final NiyetRepository _repository;

  @override
  Future<Result<List<Niyet>>> call(NoParams params) {
    return _repository.getTodayNiyetler();
  }
}
