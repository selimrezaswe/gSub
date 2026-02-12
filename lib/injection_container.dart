import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:subscription_manager/features/app_bottom_nav/presentation/cubit/app_bottom_nav_cubit.dart';
import 'package:subscription_manager/features/onboard/presentation/cubits/onboarding_cubit.dart';
import 'package:subscription_manager/features/plans/presentation/cubit/tab_cubit.dart';
import 'package:subscription_manager/features/settings/data/datasources/currency_asset_datasource.dart';
import 'package:subscription_manager/features/settings/data/repositories/currency_repository_impl.dart';
import 'package:subscription_manager/features/settings/domain/usecases/get_currencies_usecase.dart';
import 'package:subscription_manager/features/settings/presentation/cubit/select_currency_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Remember to use [registerLazySingleton] when you use the same instance in whole app, and [registerFactory] when you use the instance only one time.

  // // Battery Usage Permission dependencies
  // sl.registerLazySingleton<BatteryUsagePermissionDataSource>(
  //   () => BatteryUsagePermissionDataSourceImpl(),
  // );

  // sl.registerLazySingleton<BatteryUsagePermissionRepository>(
  //   () => BatteryUsagePermissionRepositoryImpl(sl()),
  // );

  // sl.registerLazySingleton(() => CheckBatteryUsagePermissionUsecase(sl()));
  // sl.registerLazySingleton(() => RequestBatteryUsagePermissionUsecase(sl()));
  // sl.registerLazySingleton(() => BatteryUsagePermissionCubit(sl(), sl()));
  sl.registerFactory(() => AppBottomNavCubit());
  sl.registerFactory(() => TabCubit());

  // Select currency: cubit needs AssetBundle from context at show time
  sl.registerFactoryParam<SelectCurrencyCubit, BuildContext, void>(
    (context, _) {
      final bundle = DefaultAssetBundle.of(context);
      final dataSource = CurrencyAssetDataSourceImpl(bundle);
      final repository = CurrencyRepositoryImpl(dataSource);
      final getCurrenciesUseCase = GetCurrenciesUseCase(repository);
      return SelectCurrencyCubit(getCurrenciesUseCase);
    },
  );

  sl.registerFactory(() => OnboardingCubit());
}
