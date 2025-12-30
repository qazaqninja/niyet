import 'package:flutter/material.dart';

import 'src/app/application.dart';
import 'src/app/flavor_config.dart';
import 'src/core/db/app_database.dart';
import 'src/core/services/injectable/injectable_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize flavor
  FlavorConfig.initialize(AppFlavor.dev);

  // Initialize dependency injection
  await configureInjectableDependencies();

  // Initialize database
  await AppDatabase.init();

  runApp(const NiyyahApp());
}
