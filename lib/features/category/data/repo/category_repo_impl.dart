import 'package:dio/dio.dart';
import 'package:tmed_kiosk/core/exceptions/exceptions.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/category/data/datasources/category_datasource.dart';
import 'package:tmed_kiosk/features/category/data/datasources/category_local_datasource.dart';
import 'package:tmed_kiosk/features/category/data/model/catigory_filter_model.dart';
import 'package:tmed_kiosk/features/category/domain/entity/catigory_entity.dart';
import 'package:tmed_kiosk/features/category/domain/repo/category_repo.dart';
import 'package:tmed_kiosk/features/common/controllers/auth/authentication_bloc.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';

class CategoryRepositoryIMPl extends CategoryRepository {
  final CatrgoryDataSourceImpl dataSource;
  final CatigoryLocalDataSource localDataSource;

  CategoryRepositoryIMPl(
      {required this.dataSource, required this.localDataSource});

  @override
  Future<Either<Failure, GenericPagination<CategoryEntity>>> categoryList(
      CatigoryFilter param) async {
    bool hasInternet = await isInternetConnected();
    if (hasInternet && param.search == null && param.isOfline == false) {
      try {
        final result = await dataSource.categoryList(param);
        return Right(result);
      } on DioException {
        return Left(DioFailure());
      } on ParsingException catch (e) {
        return Left(ParsingFailure(errorMessage: e.errorMessage));
      } on ServerException catch (e) {
        return Left(ServerFailure(
          errorMessage: e.errorMessage,
          statusCode: e.statusCode,
        ));
      }
    } else {
      try {
        final result = await localDataSource.categoryList(param);
        return Right(result);
      } on DioException {
        return Left(DioFailure());
      } on ParsingException catch (e) {
        return Left(ParsingFailure(errorMessage: e.errorMessage));
      } on ServerException catch (e) {
        return Left(ServerFailure(
          errorMessage: e.errorMessage,
          statusCode: e.statusCode,
        ));
      }
    }
  }
}
