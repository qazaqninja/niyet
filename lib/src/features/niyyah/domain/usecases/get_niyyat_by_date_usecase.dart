import 'package:injectable/injectable.dart';

import '../../../../core/base/base_usecase/result.dart';
import '../../../../core/base/base_usecase/use_case.dart';
import '../entities/niyyah.dart';
import '../repositories/niyyah_repository.dart';

@injectable
class GetNiyyatByDateUseCase implements UseCase<List<Niyyah>, DateTime> {
  GetNiyyatByDateUseCase(this._repository);

  final NiyyahRepository _repository;

  @override
  Future<Result<List<Niyyah>>> call(DateTime params) {
    return _repository.getNiyyatByDate(params);
  }
}
