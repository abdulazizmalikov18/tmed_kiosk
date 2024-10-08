import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tmed_kiosk/features/cart/data/models/account_balance_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/check_order_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/check_user_model.dart';
import 'package:hive/hive.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/core/exceptions/exceptions.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/features/cart/data/datasource/cart_datasource.dart';
import 'package:tmed_kiosk/features/cart/data/models/account_create_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/accounts_filter.dart';
import 'package:tmed_kiosk/features/cart/data/models/accounts_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/create_account_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_filter.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_res_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_selection.dart';
import 'package:tmed_kiosk/features/cart/data/models/history/history_filter.dart';
import 'package:tmed_kiosk/features/cart/data/models/history/history_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/merge_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/orders_creat_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/process_status_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/profession_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/recommendation/recommendation_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/region_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/update_account.dart';
import 'package:tmed_kiosk/features/cart/data/models/update_orders_model.dart';
import 'package:tmed_kiosk/features/common/models/orders_model.dart';
import 'package:tmed_kiosk/features/common/models/popular_category_filter.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';

class CartLocalDataSource extends CartDataSource {
  final box = Hive.box(StorageKeys.PRODUCTS);
  @override
  Future<GenericPagination<AccountsModel>> accountsList(
      AccountsFilter param) async {
    try {
      List<dynamic> usersJson = box.get(StorageKeys.ACCOUNTS, defaultValue: []);
      List<AccountsModel> accounts = usersJson.map((value) {
        final json = jsonEncode(value);
        final map = jsonDecode(json);
        return AccountsModel.fromJson(map);
      }).toList();
      if (param.search != null) {
        accounts = accounts
            .where((element) =>
            "${element.name}${element.lastname}${element.pinfl}${element.phone}"
                .toLowerCase()
                .contains(param.search!.toLowerCase()))
            .toList();
      }
      return GenericPagination<AccountsModel>(
        results: accounts,
        count: accounts.length,
      );
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<CreateAccountModel> createAccount(FormData formData) {
    throw UnimplementedError();
  }

  @override
  Future<OrdersModel> createOrder(OrdersCreatModel param) {
    throw UnimplementedError();
  }

  @override
  Future<GenericPagination<CuponModel>> getCoupon(CFilter filter) async {
    try {
      List<dynamic> usersJson = box.get(StorageKeys.ACCOUNTS, defaultValue: []);
      List<CuponModel> cupons = usersJson.map((value) {
        final json = jsonEncode(value);
        final map = jsonDecode(json);
        return CuponModel.fromJson(map);
      }).toList();

      return GenericPagination<CuponModel>(
        results: cupons,
        count: cupons.length,
      );
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<GenericPagination<HistoryModel>> getHistory(HFilter filter) {
    throw UnimplementedError();
  }

  @override
  Future<GenericPagination<ProfessionModel>> getProfession(Filter param) {
    throw UnimplementedError();
  }

  @override
  Future<GenericPagination<RecommendationModel>> getRecommendation(
      String username) {
    throw UnimplementedError();
  }

  @override
  Future<GenericPagination<RegionModel>> getRegion(Filter param) {
    throw UnimplementedError();
  }

  @override
  Future<CuponResModel> postCupon(CuSel param) {
    throw UnimplementedError();
  }

  @override
  Future<CheckUserModel> postPhone(AccountCreateModel parma) {
    throw UnimplementedError();
  }

  @override
  Future<bool> postPhoneConfir(String phone) {
    throw UnimplementedError();
  }

  @override
  Future<GenericPagination<ProcessStatusModel>> processStatus() async {
    try {
      List<dynamic> usersJson = box.get(StorageKeys.PRSTATUS, defaultValue: []);
      List<ProcessStatusModel> orders = usersJson.map((value) {
        final json = jsonEncode(value);
        final map = jsonDecode(json);
        return ProcessStatusModel.fromJson(map);
      }).toList();
      final pagination = GenericPagination<ProcessStatusModel>(
        results: orders,
        count: orders.length,
      );
      return pagination;
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<CuponModel> getCouponID(int id) async {
    try {
      List<dynamic> usersJson = box.get(StorageKeys.CUPONS, defaultValue: []);
      List<CuponModel> cupon = usersJson.map((value) {
        final json = jsonEncode(value);
        final map = jsonDecode(json);
        return CuponModel.fromJson(map);
      }).toList();
      final product = cupon.where((element) => element.id == id);
      if (product.isEmpty) {
        throw const ServerException(
            errorMessage: "Malumot yo'q", statusCode: 200);
      }
      return product.first;
    } on ServerException {
      rethrow;
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> updateOrder(UpdateOrdersModel param) {
    throw UnimplementedError();
  }

  @override
  Future<CuponResModel> delateCupon(CuSel param) {
    throw UnimplementedError();
  }

  @override
  Future<AccountsModel> accountUsername(String param) {
    throw UnimplementedError();
  }

  @override
  Future<AccountsModel> accountUpdate(UpdateAccount data) {
    throw UnimplementedError();
  }

  @override
  Future<AccountBalanceModel> accountBalance(String param) {
    throw UnimplementedError();
  }

  @override
  Future<bool> mergeAccount(MergeModel model) {
    throw UnimplementedError();
  }

  @override
  Future<CheckOrderModel> checkOrder(String username) {
    throw UnimplementedError();
  }

  @override
  Future<OrdersModel> orderId(String id) {
    throw UnimplementedError();
  }
}
