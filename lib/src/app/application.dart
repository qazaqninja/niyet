import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import '../core/router/router.dart';
import '../core/theme/theme.dart';
import '../features/niyyah/presentation/bloc/niyyah_bloc.dart';
import '../core/services/injectable/injectable_service.dart';
import 'flavor_config.dart';

class NiyyahApp extends StatefulWidget {
  const NiyyahApp({super.key});

  @override
  State<NiyyahApp> createState() => _NiyyahAppState();
}

class _NiyyahAppState extends State<NiyyahApp> {
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
        BlocProvider(create: (_) => getIt<NiyyahBloc>()),
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
