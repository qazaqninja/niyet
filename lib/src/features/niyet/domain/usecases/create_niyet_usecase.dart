import 'package:injectable/injectable.dart';

import '../../../../core/base/base_usecase/result.dart';
import '../../../../core/base/base_usecase/use_case.dart';
import '../entities/niyet.dart';
import '../entities/niyet_category.dart';
import '../repositories/niyet_repository.dart';

class CreateNiyetParams {
  const CreateNiyetParams({
    required this.text,
    required this.category,
    this.forAllah = true,
  });

  final String text;
  final NiyetCategory category;
  final bool forAllah;
}

@injectable
class CreateNiyetUseCase implements UseCase<Niyet, CreateNiyetParams> {
  CreateNiyetUseCase(this._repository);

  final NiyetRepository _repository;

  @override
  Future<Result<Niyet>> call(CreateNiyetParams params) {
    final now = DateTime.now();
    final niyet = Niyet(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime(now.year, now.month, now.day),
      text: params.text,
      category: params.category,
      forAllah: params.forAllah,
      createdAt: now,
    );
    return _repository.createNiyet(niyet);
  }
}
