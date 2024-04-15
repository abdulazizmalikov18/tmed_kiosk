import 'package:tmed_kiosk/features/cart/data/datasource/cart_local_datasource.dart';
import 'package:tmed_kiosk/features/category/data/datasources/category_local_datasource.dart';
import 'package:tmed_kiosk/features/goods/data/datasources/goods_local_datasource.dart';
import 'package:tmed_kiosk/features/specialists/data/datasources/specialists_local_datasource.dart';
import 'package:get_it/get_it.dart';
import 'package:tmed_kiosk/core/singletons/dio_settings.dart';
import 'package:tmed_kiosk/features/auth/data/datasources/auth_data_source.dart';
import 'package:tmed_kiosk/features/auth/data/repo/auth_set_repository_impl.dart';
import 'package:tmed_kiosk/features/cart/data/datasource/cart_datasource.dart';
import 'package:tmed_kiosk/features/cart/data/repo/cart_repo_impl.dart';
import 'package:tmed_kiosk/features/category/data/datasources/category_datasource.dart';
import 'package:tmed_kiosk/features/category/data/repo/category_repo_impl.dart';
import 'package:tmed_kiosk/features/goods/data/datasources/goods_datasource.dart';
import 'package:tmed_kiosk/features/goods/data/repo/goods_repo_impl.dart';
import 'package:tmed_kiosk/features/specialists/data/datasources/specialists_datasources.dart';
import 'package:tmed_kiosk/features/specialists/data/repo/specialists_repo_impl.dart';

final serviceLocator = GetIt.I;

void setupLocator() {
  serviceLocator
    ..registerLazySingleton(DioSettings.new)
    ..registerLazySingleton(
      () => AuthSetRepositoryImpl(dataSource: AuthDataSourcheImpl()),
    )
    ..registerLazySingleton(
      () => CategoryRepositoryIMPl(
          dataSource: CatrgoryDataSourceImpl(),
          localDataSource: CatigoryLocalDataSource()),
    )
    ..registerLazySingleton(
      () => SpecialistsRepositoryImpl(
          dataSource: SpecialistsDataSourceImpl(),
          localDataSource: SpecialistsLocalDataSource()),
    )
    ..registerLazySingleton(
      () => GoodsRepoImpl(
        dataSource: GoodsDataSourceImpl(),
        localDataSource: GoodsLocalDataSource(),
      ),
    )
    ..registerLazySingleton(
      () => CartRepoImpl(
          dataSource: CartDataSourceImpl(),
          localDataSource: CartLocalDataSource()),
    );
}

Future resetLocator() async {
  await serviceLocator.reset();
  setupLocator();
}
