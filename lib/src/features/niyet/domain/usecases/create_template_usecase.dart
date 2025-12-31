import 'package:injectable/injectable.dart';

import '../../../../core/base/base_usecase/result.dart';
import '../../../../core/base/base_usecase/use_case.dart';
import '../entities/niyet_category.dart';
import '../entities/niyet_template.dart';
import '../repositories/niyet_template_repository.dart';

class CreateTemplateParams {
  const CreateTemplateParams({
    required this.text,
    required this.category,
  });

  final String text;
  final NiyetCategory category;
}

@injectable
class CreateTemplateUseCase implements UseCase<NiyetTemplate, CreateTemplateParams> {
  CreateTemplateUseCase(this._repository);

  final NiyetTemplateRepository _repository;

  @override
  Future<Result<NiyetTemplate>> call(CreateTemplateParams params) {
    final template = NiyetTemplate(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: params.text,
      category: params.category,
      isDefault: false,
      createdAt: DateTime.now(),
    );
    return _repository.createTemplate(template);
  }
}
