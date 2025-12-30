import 'package:injectable/injectable.dart';

import '../../../../core/base/base_usecase/result.dart';
import '../../../../core/base/base_usecase/use_case.dart';
import '../entities/niyyah.dart';
import '../entities/niyyah_category.dart';
import '../repositories/niyyah_repository.dart';

class CreateNiyyahParams {
  const CreateNiyyahParams({
    required this.text,
    required this.category,
    this.forAllah = true,
  });

  final String text;
  final NiyyahCategory category;
  final bool forAllah;
}

@injectable
class CreateNiyyahUseCase implements UseCase<Niyyah, CreateNiyyahParams> {
  CreateNiyyahUseCase(this._repository);

  final NiyyahRepository _repository;

  @override
  Future<Result<Niyyah>> call(CreateNiyyahParams params) {
    final now = DateTime.now();
    final niyyah = Niyyah(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime(now.year, now.month, now.day),
      text: params.text,
      category: params.category,
      forAllah: params.forAllah,
      createdAt: now,
    );
    return _repository.createNiyyah(niyyah);
  }
}
