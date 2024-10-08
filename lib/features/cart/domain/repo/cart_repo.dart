import 'package:dio/dio.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/cart/data/models/account_balance_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/account_create_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/accounts_filter.dart';
import 'package:tmed_kiosk/features/cart/data/models/check_order_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/check_user_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_filter.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_selection.dart';
import 'package:tmed_kiosk/features/cart/data/models/history/history_filter.dart';
import 'package:tmed_kiosk/features/cart/data/models/merge_model.dart';
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
import 'package:tmed_kiosk/features/common/entity/orders_entity.dart';
import 'package:tmed_kiosk/features/common/models/popular_category_filter.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';

abstract class CartRepo {
  Future<Either<Failure, OrdersEntity>> createOrder(OrdersCreatModel param);
  Future<Either<Failure, GenericPagination<AccountsEntity>>> accountsList(
      AccountsFilter param);
  Future<Either<Failure, AccountsEntity>> accountUsername(String param);
  Future<Either<Failure, GenericPagination<RegionEntity>>> getRegion(
      Filter param);
  Future<Either<Failure, GenericPagination<ProfessionEntity>>> getProfession(
      Filter id);
  Future<Either<Failure, GenericPagination<CuponModel>>> getCoupon(
      CFilter filter);
  Future<Either<Failure, CuponModel>> getCouponID(int id);
  Future<Either<Failure, CheckUserModel>> postPhone(AccountCreateModel parma);
  Future<Either<Failure, bool>> postPhoneConfir(String phone);
  Future<Either<Failure, CreateAccountEntity>> createAccount(FormData formData);
  Future<Either<Failure, GenericPagination<ProcessStatusEntity>>>
  processStatus();
  Future<Either<Failure, bool>> mergeAccount(MergeModel model);
  Future<Either<Failure, GenericPagination<HistoryEntity>>> getHistory(
      HFilter filter);
  Future<Either<Failure, CuponResEntity>> postCupon(CuSel param);
  Future<Either<Failure, CuponResEntity>> delateCupon(CuSel param);
  Future<Either<Failure, GenericPagination<RecommendationModel>>>
  getRecommendation(String username);
  Future<Either<Failure, bool>> updateOrder(UpdateOrdersModel param);
  Future<Either<Failure, AccountBalanceModel>> accountBalance(String param);
  Future<Either<Failure, AccountsEntity>> accountUpdate(UpdateAccount data);
  Future<Either<Failure, CheckOrderModel>> checkOrder(String data);
  Future<Either<Failure, OrdersEntity>> orderId(String data);
}
