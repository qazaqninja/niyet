import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import '../core/router/router.dart';
import '../core/theme/theme.dart';
import '../features/niyet/presentation/bloc/niyet_bloc.dart';
import '../core/services/injectable/injectable_service.dart';
import 'flavor_config.dart';

class NiyetApp extends StatefulWidget {
  const NiyetApp({super.key});

  @override
  State<NiyetApp> createState() => _NiyetAppState();
}

class _NiyetAppState extends State<NiyetApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = createRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<NiyetBloc>()),
      ],
      child: MaterialApp.router(
        title: FlavorConfig.instance.appTitle,
        debugShowCheckedModeBanner: FlavorConfig.instance.isDev,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: _router,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
          Locale('kk'),
        ],
      ),
    );
  }
}
