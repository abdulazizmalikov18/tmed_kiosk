import 'package:dio/dio.dart';
import 'package:tmed_kiosk/core/exceptions/exceptions.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/cart/data/datasource/cart_datasource.dart';
import 'package:tmed_kiosk/features/cart/data/datasource/cart_local_datasource.dart';
import 'package:tmed_kiosk/features/cart/data/models/account_create_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/accounts_filter.dart';
import 'package:tmed_kiosk/features/cart/data/models/check_user_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_filter.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_selection.dart';
import 'package:tmed_kiosk/features/cart/data/models/history/history_filter.dart';
import 'package:tmed_kiosk/features/cart/data/models/orders_creat_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/update_account.dart';
import 'package:tmed_kiosk/features/cart/data/models/update_orders_model.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/accounts_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/create_account.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_model.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/cupon_res_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/process_status_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/profession_entity.dart';
import 'package:tmed_kiosk/features/cart/data/models/recommendation/recommendation_model.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/region_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/repo/cart_repo.dart';
import 'package:tmed_kiosk/features/common/controllers/auth/authentication_bloc.dart';
import 'package:tmed_kiosk/features/common/entity/orders_entity.dart';
import 'package:tmed_kiosk/features/common/models/popular_category_filter.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';

class CartRepoImpl extends CartRepo {
  final CartDataSourceImpl dataSource;
  final CartLocalDataSource localDataSource;

  CartRepoImpl({required this.dataSource, required this.localDataSource});

  @override
  Future<Either<Failure, GenericPagination<AccountsEntity>>> accountsList(
      AccountsFilter param) async {
    bool isConnection = await isInternetConnected();
    if (isConnection) {
      try {
        final result = await dataSource.accountsList(param);
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
        final result = await localDataSource.accountsList(param);
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
  Future<Either<Failure, GenericPagination<RegionEntity>>> getRegion(
      Filter param) async {
    try {
      final result = await dataSource.getRegion(param);
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
  Future<Either<Failure, CheckUserModel>> postPhone(
      AccountCreateModel parma) async {
    try {
      final result = await dataSource.postPhone(parma);
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
  Future<Either<Failure, bool>> postPhoneConfir(String phone) async {
    try {
      final result = await dataSource.postPhoneConfir(phone);
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
  Future<Either<Failure, CreateAccountEntity>> createAccount(
      FormData formData) async {
    try {
      final result = await dataSource.createAccount(formData);
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

  // @override
  // Future<Either<Failure, GenericPagination<ProcessWorkEntity>>>
  //     prcessWork() async {
  //   try {
  //     final result = await dataSource.prcessWork();
  //     return Right(result);
  //   } on DioException {
  //     return Left(DioFailure());
  //   } on ParsingException catch (e) {
  //     return Left(ParsingFailure(errorMessage: e.errorMessage));
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(
  //       errorMessage: e.errorMessage,
  //       statusCode: e.statusCode,
  //     ));
  //   }
  // }

  @override
  Future<Either<Failure, GenericPagination<ProcessStatusEntity>>>
      processStatus() async {
    bool isConnection = await isInternetConnected();
    if (isConnection) {
      try {
        final result = await dataSource.processStatus();
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
        final result = await localDataSource.processStatus();
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
  Future<Either<Failure, OrdersEntity>> createOrder(
      OrdersCreatModel param) async {
    try {
      final result = await dataSource.createOrder(param);
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
  Future<Either<Failure, GenericPagination<CuponModel>>> getCoupon(
      CFilter filter) async {
    bool isConnection = await isInternetConnected();
    if (isConnection) {
      try {
        final result = await dataSource.getCoupon(filter);
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
        final result = await localDataSource.getCoupon(filter);
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
  Future<Either<Failure, GenericPagination<ProfessionEntity>>> getProfession(
      Filter id) async {
    try {
      final result = await dataSource.getProfession(id);
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
  Future<Either<Failure, GenericPagination<HistoryEntity>>> getHistory(
      HFilter filter) async {
    try {
      final result = await dataSource.getHistory(filter);
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
  Future<Either<Failure, CuponResEntity>> postCupon(CuSel param) async {
    try {
      final result = await dataSource.postCupon(param);
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
  Future<Either<Failure, GenericPagination<RecommendationModel>>>
      getRecommendation(String username) async {
    try {
      final result = await dataSource.getRecommendation(username);
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
  Future<Either<Failure, CuponModel>> getCouponID(int id) async {
    try {
      final result = await localDataSource.getCouponID(id);
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
  Future<Either<Failure, bool>> updateOrder(UpdateOrdersModel param) async {
    try {
      final result = await dataSource.updateOrder(param);
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
  Future<Either<Failure, CuponResEntity>> delateCupon(CuSel param) async {
    try {
      final result = await dataSource.delateCupon(param);
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
  Future<Either<Failure, AccountsEntity>> accountUsername(String param) async {
    if (!await isInternetConnected()) {
      return Left(NetworkFailure(errorMessage: 'Connection failure'));
    }
    try {
      final result = await dataSource.accountUsername(param);
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
  Future<Either<Failure, AccountsEntity>> accountUpdate(
      UpdateAccount data) async {
    if (!await isInternetConnected()) {
      return Left(NetworkFailure(errorMessage: 'Connection failure'));
    }
    try {
      final result = await dataSource.accountUpdate(data);
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
