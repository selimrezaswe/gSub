import 'package:get_it/get_it.dart';
import 'package:subscription_manager/features/app_bottom_nav/presentation/cubit/app_bottom_nav_cubit.dart';

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
}
