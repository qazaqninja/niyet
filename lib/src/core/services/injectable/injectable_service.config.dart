// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:niyet/src/core/db/app_database.dart' as _i364;
import 'package:niyet/src/core/services/injectable/modules/database_module.dart'
    as _i423;
import 'package:niyet/src/core/services/injectable/modules/preferences_module.dart'
    as _i542;
import 'package:niyet/src/core/services/preferences/preferences_service.dart'
    as _i1006;
import 'package:niyet/src/core/services/ramadan/ramadan_service.dart' as _i328;
import 'package:niyet/src/core/services/sun_times/sun_times_service.dart'
    as _i276;
import 'package:niyet/src/core/theme/theme_cubit.dart' as _i598;
import 'package:niyet/src/features/calendar/domain/usecases/get_niyetler_in_range_usecase.dart'
    as _i769;
import 'package:niyet/src/features/calendar/presentation/bloc/calendar_bloc.dart'
    as _i623;
import 'package:niyet/src/features/niyet/data/datasources/niyet_local_datasource.dart'
    as _i972;
import 'package:niyet/src/features/niyet/data/datasources/niyet_template_local_datasource.dart'
    as _i667;
import 'package:niyet/src/features/niyet/data/repositories/niyet_repository_impl.dart'
    as _i807;
import 'package:niyet/src/features/niyet/data/repositories/niyet_template_repository_impl.dart'
    as _i849;
import 'package:niyet/src/features/niyet/domain/repositories/niyet_repository.dart'
    as _i869;
import 'package:niyet/src/features/niyet/domain/repositories/niyet_template_repository.dart'
    as _i888;
import 'package:niyet/src/features/niyet/domain/usecases/create_niyet_usecase.dart'
    as _i172;
import 'package:niyet/src/features/niyet/domain/usecases/create_template_usecase.dart'
    as _i203;
import 'package:niyet/src/features/niyet/domain/usecases/get_niyetler_by_date_usecase.dart'
    as _i695;
import 'package:niyet/src/features/niyet/domain/usecases/get_templates_usecase.dart'
    as _i376;
import 'package:niyet/src/features/niyet/domain/usecases/get_today_niyetler_usecase.dart'
    as _i15;
import 'package:niyet/src/features/niyet/domain/usecases/update_niyet_outcome_usecase.dart'
    as _i684;
import 'package:niyet/src/features/niyet/presentation/bloc/niyet_bloc.dart'
    as _i507;
import 'package:niyet/src/features/niyet/presentation/bloc/template_bloc.dart'
    as _i390;
import 'package:niyet/src/features/onboarding/presentation/bloc/onboarding_bloc.dart'
    as _i620;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final preferencesModule = _$PreferencesModule();
    final databaseModule = _$DatabaseModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => preferencesModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i364.AppDatabase>(() => databaseModule.database);
    gh.lazySingleton<_i328.RamadanService>(() => _i328.RamadanServiceImpl());
    gh.lazySingleton<_i667.NiyetTemplateLocalDataSource>(
      () => _i667.NiyetTemplateLocalDataSourceImpl(gh<_i364.AppDatabase>()),
    );
    gh.lazySingleton<_i972.NiyetLocalDataSource>(
      () => _i972.NiyetLocalDataSourceImpl(gh<_i364.AppDatabase>()),
    );
    gh.lazySingleton<_i1006.PreferencesService>(
      () => _i1006.PreferencesServiceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i620.OnboardingBloc>(
      () => _i620.OnboardingBloc(
        preferencesService: gh<_i1006.PreferencesService>(),
      ),
    );
    gh.lazySingleton<_i276.SunTimesService>(
      () => _i276.SunTimesServiceImpl(gh<_i1006.PreferencesService>()),
    );
    gh.lazySingleton<_i869.NiyetRepository>(
      () => _i807.NiyetRepositoryImpl(gh<_i972.NiyetLocalDataSource>()),
    );
    gh.lazySingleton<_i888.NiyetTemplateRepository>(
      () => _i849.NiyetTemplateRepositoryImpl(
        gh<_i667.NiyetTemplateLocalDataSource>(),
      ),
    );
    gh.factory<_i598.ThemeCubit>(
      () => _i598.ThemeCubit(
        gh<_i276.SunTimesService>(),
        gh<_i328.RamadanService>(),
      ),
    );
    gh.factory<_i203.CreateTemplateUseCase>(
      () => _i203.CreateTemplateUseCase(gh<_i888.NiyetTemplateRepository>()),
    );
    gh.factory<_i376.GetTemplatesUseCase>(
      () => _i376.GetTemplatesUseCase(gh<_i888.NiyetTemplateRepository>()),
    );
    gh.factory<_i390.TemplateBloc>(
      () => _i390.TemplateBloc(
        getTemplates: gh<_i376.GetTemplatesUseCase>(),
        createTemplate: gh<_i203.CreateTemplateUseCase>(),
        repository: gh<_i888.NiyetTemplateRepository>(),
      ),
    );
    gh.factory<_i684.UpdateNiyetOutcomeUseCase>(
      () => _i684.UpdateNiyetOutcomeUseCase(gh<_i869.NiyetRepository>()),
    );
    gh.factory<_i172.CreateNiyetUseCase>(
      () => _i172.CreateNiyetUseCase(gh<_i869.NiyetRepository>()),
    );
    gh.factory<_i695.GetNiyetlerByDateUseCase>(
      () => _i695.GetNiyetlerByDateUseCase(gh<_i869.NiyetRepository>()),
    );
    gh.factory<_i15.GetTodayNiyetlerUseCase>(
      () => _i15.GetTodayNiyetlerUseCase(gh<_i869.NiyetRepository>()),
    );
    gh.factory<_i769.GetNiyetlerInRangeUseCase>(
      () => _i769.GetNiyetlerInRangeUseCase(gh<_i869.NiyetRepository>()),
    );
    gh.factory<_i623.CalendarBloc>(
      () => _i623.CalendarBloc(
        getNiyetlerInRange: gh<_i769.GetNiyetlerInRangeUseCase>(),
      ),
    );
    gh.factory<_i507.NiyetBloc>(
      () => _i507.NiyetBloc(
        getTodayNiyetler: gh<_i15.GetTodayNiyetlerUseCase>(),
        createNiyet: gh<_i172.CreateNiyetUseCase>(),
        updateNiyetOutcome: gh<_i684.UpdateNiyetOutcomeUseCase>(),
        repository: gh<_i869.NiyetRepository>(),
      ),
    );
    return this;
  }
}

class _$PreferencesModule extends _i542.PreferencesModule {}

class _$DatabaseModule extends _i423.DatabaseModule {}
