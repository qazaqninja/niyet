import 'package:injectable/injectable.dart';

import '../../../db/app_database.dart';

@module
abstract class DatabaseModule {
  @lazySingleton
  AppDatabase get database => AppDatabase.instance;
}
