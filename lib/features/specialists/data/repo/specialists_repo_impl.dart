import 'package:dio/dio.dart';
import 'package:tmed_kiosk/core/exceptions/exceptions.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/common/controllers/auth/authentication_bloc.dart';
import 'package:tmed_kiosk/features/common/models/popular_category_filter.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';
import 'package:tmed_kiosk/features/specialists/data/datasources/specialists_datasources.dart';
import 'package:tmed_kiosk/features/specialists/data/datasources/specialists_local_datasource.dart';
import 'package:tmed_kiosk/features/specialists/data/model/specil_filter.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/day_id.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/spec_cat_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/specialist_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/today_time_table_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/repo/specialists_repo.dart';

class SpecialistsRepositoryImpl extends SpecialistsRepository {
  final SpecialistsDataSourceImpl dataSource;
  final SpecialistsLocalDataSource localDataSource;

  SpecialistsRepositoryImpl(
      {required this.dataSource, required this.localDataSource});
  @override
  Future<Either<Failure, GenericPagination<SpecialistsEntity>>> getSpecialists(
      SpecialFilter param) async {
    bool hasInternet = await isInternetConnected();
    if (hasInternet && param.search == null ||
        param.search!.length % 3 == 0 &&
            param.specCat == null &&
            param.canel == false) {
      try {
        final result = await dataSource.getSpecialists(param);
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
        final result = await localDataSource.getSpecialists(param);
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
  Future<Either<Failure, GenericPagination<SpecCatEntity>>> getSpecialistCats(
      Filter param) async {
    bool hasInternet = await isInternetConnected();
    if (hasInternet) {
      try {
        final result = await dataSource.getSpecialistCats(param);
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
        final result = await localDataSource.getSpecialistCats(param);
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
  Future<Either<Failure, GenericPagination<TodayTimetableEntity>>> getTimetable(
      int id) async {
    try {
      final result = await dataSource.getTimetable(id);
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
  Future<Either<Failure, TodayTimetableEntity>> getTimetableDay(
      DayId param) async {
    try {
      final result = await dataSource.getTimetableDay(param);
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
