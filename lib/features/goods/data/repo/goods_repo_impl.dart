import 'package:dio/dio.dart';
import 'package:tmed_kiosk/core/exceptions/exceptions.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/common/controllers/auth/authentication_bloc.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';
import 'package:tmed_kiosk/features/goods/data/datasources/goods_datasource.dart';
import 'package:tmed_kiosk/features/goods/data/datasources/goods_local_datasource.dart';
import 'package:tmed_kiosk/features/goods/data/model/goods_query_parameters.dart';
import 'package:tmed_kiosk/features/goods/data/model/org_product_model.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/supplies_entity.dart';
import 'package:tmed_kiosk/features/goods/domain/repo/goods_repo.dart';
import 'package:tmed_kiosk/features/main/domain/entity/product_specia.dart';

class GoodsRepoImpl extends GoodsRepo {
  final GoodsDataSourceImpl dataSource;
  final GoodsLocalDataSource localDataSource;

  GoodsRepoImpl({
    required this.dataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, GenericPagination<OrgProductModel>>> getOrgProduct(
      GoodsQueryParam param) async {
    bool hasInternet = await isInternetConnected();
    if (hasInternet) {
      try {
        final result = await dataSource.getOrgProduct(param);
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
        final result = await localDataSource.getOrgProduct(param);
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

  @override
  Future<Either<Failure, GenericPagination<SuppliesEntity>>> getSupplies(
      int id) async {
    bool hasInternet = await isInternetConnected();
    if (hasInternet) {
      try {
        final result = await dataSource.getSupplies(id);
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
        final result = await localDataSource.getSupplies(id);
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

  @override
  Future<Either<Failure, GenericPagination<ProductSpecialEntity>>> getPSp(
      int id) async {
    try {
      final result = await dataSource.getPSp(id);
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

  @override
  Future<Either<Failure, OrgProductEntity>> getOrgProductID(int param) async {
    bool hasInternet = await isInternetConnected();
    if (hasInternet) {
      try {
        final result = await dataSource.getOrgProductID(param);
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
        final result = await localDataSource.getOrgProductID(param);
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

  @override
  Future<Either<Failure, OrgProductEntity>> getProductBarCode(
      String param) async {
    try {
      final result = await localDataSource.getProductBarCode(param);
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

  @override
  Future<Either<Failure, List<OrgProductEntity>>> getOrgProductIDList(
      List<int> param) async {
    try {
      final result = await localDataSource.getOrgProductIDList(param);
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
