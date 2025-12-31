import 'package:injectable/injectable.dart';

import '../../../../core/base/base_usecase/result.dart';
import '../../../../core/base/base_usecase/use_case.dart';
import '../entities/niyet_template.dart';
import '../repositories/niyet_template_repository.dart';

@injectable
class GetTemplatesUseCase implements UseCase<List<NiyetTemplate>, NoParams> {
  GetTemplatesUseCase(this._repository);

  final NiyetTemplateRepository _repository;

  @override
  Future<Result<List<NiyetTemplate>>> call(NoParams params) {
    return _repository.getTemplates();
  }
}
