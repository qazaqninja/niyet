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
import 'package:niyet/src/features/niyyah/data/datasources/niyyah_local_datasource.dart'
    as _i824;
import 'package:niyet/src/features/niyyah/data/repositories/niyyah_repository_impl.dart'
    as _i161;
import 'package:niyet/src/features/niyyah/domain/repositories/niyyah_repository.dart'
    as _i344;
import 'package:niyet/src/features/niyyah/domain/usecases/create_niyyah_usecase.dart'
    as _i713;
import 'package:niyet/src/features/niyyah/domain/usecases/get_niyyat_by_date_usecase.dart'
    as _i754;
import 'package:niyet/src/features/niyyah/domain/usecases/get_today_niyyat_usecase.dart'
    as _i405;
import 'package:niyet/src/features/niyyah/domain/usecases/update_niyyah_outcome_usecase.dart'
    as _i729;
import 'package:niyet/src/features/niyyah/presentation/bloc/niyyah_bloc.dart'
    as _i149;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final databaseModule = _$DatabaseModule();
    gh.lazySingleton<_i364.AppDatabase>(() => databaseModule.database);
    gh.lazySingleton<_i824.NiyyahLocalDataSource>(
      () => _i824.NiyyahLocalDataSourceImpl(gh<_i364.AppDatabase>()),
    );
    gh.lazySingleton<_i344.NiyyahRepository>(
      () => _i161.NiyyahRepositoryImpl(gh<_i824.NiyyahLocalDataSource>()),
    );
    gh.factory<_i754.GetNiyyatByDateUseCase>(
      () => _i754.GetNiyyatByDateUseCase(gh<_i344.NiyyahRepository>()),
    );
    gh.factory<_i729.UpdateNiyyahOutcomeUseCase>(
      () => _i729.UpdateNiyyahOutcomeUseCase(gh<_i344.NiyyahRepository>()),
    );
    gh.factory<_i713.CreateNiyyahUseCase>(
      () => _i713.CreateNiyyahUseCase(gh<_i344.NiyyahRepository>()),
    );
    gh.factory<_i405.GetTodayNiyyatUseCase>(
      () => _i405.GetTodayNiyyatUseCase(gh<_i344.NiyyahRepository>()),
    );
    gh.factory<_i149.NiyyahBloc>(
      () => _i149.NiyyahBloc(
        getTodayNiyyat: gh<_i405.GetTodayNiyyatUseCase>(),
        createNiyyah: gh<_i713.CreateNiyyahUseCase>(),
        updateNiyyahOutcome: gh<_i729.UpdateNiyyahOutcomeUseCase>(),
        repository: gh<_i344.NiyyahRepository>(),
      ),
    );
    return this;
  }
}

class _$DatabaseModule extends _i423.DatabaseModule {}
