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
import 'package:niyet/src/features/niyet/data/datasources/niyet_local_datasource.dart'
    as _i972;
import 'package:niyet/src/features/niyet/data/repositories/niyet_repository_impl.dart'
    as _i807;
import 'package:niyet/src/features/niyet/domain/repositories/niyet_repository.dart'
    as _i869;
import 'package:niyet/src/features/niyet/domain/usecases/create_niyet_usecase.dart'
    as _i172;
import 'package:niyet/src/features/niyet/domain/usecases/get_niyetler_by_date_usecase.dart'
    as _i695;
import 'package:niyet/src/features/niyet/domain/usecases/get_today_niyetler_usecase.dart'
    as _i15;
import 'package:niyet/src/features/niyet/domain/usecases/update_niyet_outcome_usecase.dart'
    as _i684;
import 'package:niyet/src/features/niyet/presentation/bloc/niyet_bloc.dart'
    as _i507;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final databaseModule = _$DatabaseModule();
    gh.lazySingleton<_i364.AppDatabase>(() => databaseModule.database);
    gh.lazySingleton<_i972.NiyetLocalDataSource>(
      () => _i972.NiyetLocalDataSourceImpl(gh<_i364.AppDatabase>()),
    );
    gh.lazySingleton<_i869.NiyetRepository>(
      () => _i807.NiyetRepositoryImpl(gh<_i972.NiyetLocalDataSource>()),
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

class _$DatabaseModule extends _i423.DatabaseModule {}
