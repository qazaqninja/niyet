import 'package:injectable/injectable.dart';

import '../../../../core/base/base_usecase/result.dart';
import '../../../../core/base/base_usecase/use_case.dart';
import '../entities/niyyah.dart';
import '../repositories/niyyah_repository.dart';

@injectable
class GetTodayNiyyatUseCase implements UseCase<List<Niyyah>, NoParams> {
  GetTodayNiyyatUseCase(this._repository);

  final NiyyahRepository _repository;

  @override
  Future<Result<List<Niyyah>>> call(NoParams params) {
    return _repository.getTodayNiyyat();
  }
}
