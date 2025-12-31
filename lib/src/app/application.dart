import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import '../core/localization/generated/app_localizations.dart';
import '../core/router/router.dart';
import '../core/services/injectable/injectable_service.dart';
import '../core/theme/animations.dart';
import '../core/theme/theme_cubit.dart';
import '../features/niyet/presentation/bloc/niyet_bloc.dart';
import '../features/niyet/presentation/bloc/template_bloc.dart';
import 'flavor_config.dart';

class NiyetApp extends StatefulWidget {
  const NiyetApp({
    this.showOnboarding = false,
    super.key,
  });

  final bool showOnboarding;

  @override
  State<NiyetApp> createState() => _NiyetAppState();
}

class _NiyetAppState extends State<NiyetApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = createRouter(
      initialLocation: widget.showOnboarding ? '/onboarding' : '/',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ThemeCubit>()..initialize(),
        ),
        BlocProvider(create: (_) => getIt<NiyetBloc>()),
        BlocProvider(
          create: (_) => getIt<TemplateBloc>()..add(const TemplateLoadRequested()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return AnimatedTheme(
            duration: AppAnimations.themeTransition,
            data: themeState.theme,
            child: MaterialApp.router(
              title: FlavorConfig.instance.appTitle,
              debugShowCheckedModeBanner: FlavorConfig.instance.isDev,
              theme: themeState.theme,
              routerConfig: _router,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('kk'),
                Locale('en'),
                Locale('ar'),
              ],
              locale: const Locale('kk'),
            ),
          );
        },
      ),
    );
  }
}
