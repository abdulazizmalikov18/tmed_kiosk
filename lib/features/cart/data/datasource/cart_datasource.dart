// ignore_for_file: deprecated_member_use
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/core/exceptions/exceptions.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/singletons/dio_settings.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/features/cart/data/models/account_create_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/accounts_filter.dart';
import 'package:tmed_kiosk/features/cart/data/models/accounts_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/check_user_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/create_account_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_filter.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_res_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_selection.dart';
import 'package:tmed_kiosk/features/cart/data/models/history/history_filter.dart';
import 'package:tmed_kiosk/features/cart/data/models/history/history_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/orders_creat_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/process_status_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/profession_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/recommendation/recommendation_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/region_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/update_orders_model.dart';
import 'package:tmed_kiosk/features/common/models/orders_model.dart';
import 'package:tmed_kiosk/features/common/models/popular_category_filter.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';

abstract class CartDataSource {
  Future<OrdersModel> createOrder(OrdersCreatModel param);
  Future<GenericPagination<AccountsModel>> accountsList(AccountsFilter param);
  Future<AccountsModel> accountUsername(String param);
  Future<GenericPagination<RegionModel>> getRegion(Filter param);
  Future<GenericPagination<ProfessionModel>> getProfession(Filter param);
  Future<GenericPagination<CuponModel>> getCoupon(CFilter filter);
  Future<CuponModel> getCouponID(int id);
  Future<CheckUserModel> postPhone(AccountCreateModel parma);
  Future<bool> postPhoneConfir(String phone);
  Future<CreateAccountModel> createAccount(FormData formData);
  Future<GenericPagination<ProcessStatusModel>> processStatus();
  // Future<GenericPagination<ProcessWorkModel>> prcessWork();
  Future<GenericPagination<HistoryModel>> getHistory(HFilter filter);
  Future<CuponResModel> postCupon(CuSel param);
  Future<CuponResModel> delateCupon(CuSel param);
  Future<bool> updateOrder(UpdateOrdersModel param);
  Future<GenericPagination<RecommendationModel>> getRecommendation(
      String username);
}

class CartDataSourceImpl extends CartDataSource {
  final dio = serviceLocator<DioSettings>().dio;
  final box = Hive.box(StorageKeys.PRODUCTS);

  @override
  Future<AccountsModel> accountUsername(String param) async {
    try {
      final response = await dio.get(
        'UMS/api/v1.0/business/accounts/$param/',
        options: Options(
          headers: StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty
              ? {
                  'Authorization':
                      'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
                }
              : {},
        ),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return AccountsModel.fromJson(response.data as Map<String, dynamic>);
      }
      throw ServerException(
        statusCode: response.statusCode ?? 0,
        errorMessage: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioError catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<GenericPagination<AccountsModel>> accountsList(
      AccountsFilter param) async {
    try {
      final response = await dio.get(
        'UMS/api/v1.0/business/accounts/',
        options: Options(
          headers: StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty
              ? {
                  'Authorization':
                      'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
                }
              : {},
        ),
        queryParameters: param.toJson(),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final List<dynamic> existingData =
            box.get(StorageKeys.ACCOUNTS, defaultValue: []);
        final List<dynamic> newData = response.data['results'];
        final mergedData = List.from(existingData);
        for (final item in newData) {
          final existingItemIndex =
              mergedData.indexWhere((e) => e['id'] == item['id']);
          if (existingItemIndex == -1) {
            mergedData.add(item);
          } else {
            mergedData[existingItemIndex] = item;
          }
        }
        await box.put(StorageKeys.ACCOUNTS, mergedData);
        return GenericPagination.fromJson(
          response.data,
          (p0) => AccountsModel.fromJson(p0 as Map<String, dynamic>),
        );
      }

      throw ServerException(
        statusCode: response.statusCode ?? 0,
        errorMessage: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioError catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<GenericPagination<RegionModel>> getRegion(Filter param) async {
    try {
      final response = await dio.get(
        'GMS/api/v1.0/public/region/',
        options: Options(
          headers: StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty
              ? {
                  'Authorization':
                      'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
                }
              : {},
        ),
        queryParameters: param.toJson(),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson(
          response.data,
          (p0) => RegionModel.fromJson(p0 as Map<String, dynamic>),
        );
      }

      throw ServerException(
        statusCode: response.statusCode ?? 0,
        errorMessage: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioError catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<CheckUserModel> postPhone(AccountCreateModel parma) async {
    try {
      final response = await dio.post(
        'UMS/api/v1.0/account/check-user/?login_params=${parma.param}',
        options: Options(
          headers: StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty
              ? {
                  'Authorization':
                      'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
                }
              : {},
        ),
        data: parma.mydata,
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return CheckUserModel.fromJson(response.data);
      }

      throw ServerException(
        statusCode: response.statusCode ?? 0,
        errorMessage: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioError catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> postPhoneConfir(String phone) async {
    try {
      final response = await dio.post(
        'UMS/api/v1.0/account/confirm-pvc/',
        options: Options(
          headers: StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty
              ? {
                  'Authorization':
                      'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
                }
              : {},
        ),
        data: {"phone": phone.substring(1), "pvc": "000000"},
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return true;
      }
      throw ServerException(
        statusCode: response.statusCode ?? 0,
        errorMessage: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioError catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<CreateAccountModel> createAccount(FormData formData) async {
    try {
      final response = await dio.post(
        'UMS/api/v1.0/account/create/',
        options: Options(
          headers: StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty
              ? {
                  'Authorization':
                      'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
                }
              : {},
        ),
        data: formData,
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return CreateAccountModel.fromJson(response.data);
      }
      throw ServerException(
        statusCode: response.statusCode ?? 0,
        errorMessage: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioError catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  // @override
  // Future<GenericPagination<ProcessWorkModel>> prcessWork() async {
  //   try {
  //     final response = await dio.get(
  //       'OMS/api/v1.0/business/${StorageRepository.getString(StorageKeys.COMPID)}/process_work/',
  //       options: Options(
  //         headers: StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty
  //             ? {
  //                 'Authorization':
  //                     'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
  //               }
  //             : {},
  //       ),
  //     );
  //     if (response.statusCode! >= 200 && response.statusCode! < 300) {
  //       return GenericPagination.fromJson(
  //         response.data,
  //         (p0) => ProcessWorkModel.fromJson(p0 as Map<String, dynamic>),
  //       );
  //     }
  //     throw ServerException(
  //       statusCode: response.statusCode ?? 0,
  //       errorMessage: response.statusMessage ?? '',
  //     );
  //   } on ServerException {
  //     rethrow;
  //   } on DioError {
  //     throw DioExceptions();
  //   } on Exception catch (e) {
  //     throw ParsingException(errorMessage: e.toString());
  //   }
  // }

  @override
  Future<GenericPagination<ProcessStatusModel>> processStatus() async {
    try {
      final response = await dio.get(
        'OMS/api/v1.0/business/${StorageRepository.getString(StorageKeys.COMPID)}/process-status/',
        options: Options(
          headers: StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty
              ? {
                  'Authorization':
                      'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
                }
              : {},
        ),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final List<dynamic> existingData =
            box.get(StorageKeys.PRSTATUS, defaultValue: []);
        final List<dynamic> newData = response.data['results'];
        final mergedData = List.from(existingData);
        for (final item in newData) {
          final existingItemIndex =
              mergedData.indexWhere((e) => e['id'] == item['id']);
          if (existingItemIndex == -1) {
            mergedData.add(item);
          } else {
            mergedData[existingItemIndex] = item;
          }
        }
        await box.put(StorageKeys.PRSTATUS, mergedData);
        return GenericPagination.fromJson(
          response.data,
          (p0) => ProcessStatusModel.fromJson(p0 as Map<String, dynamic>),
        );
      }
      throw ServerException(
        statusCode: response.statusCode ?? 0,
        errorMessage: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioError catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<OrdersModel> createOrder(OrdersCreatModel param) async {
    try {
      final response = await dio.post(
        'OMS/api/v1.0/business/${StorageRepository.getString(StorageKeys.COMPID)}/order/create/',
        options: Options(
          headers: StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty
              ? {
                  'Authorization':
                      'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
                }
              : {},
        ),
        data: param.toJson(),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return OrdersModel.fromJson(response.data);
      }
      throw ServerException(
        statusCode: response.statusCode ?? 0,
        errorMessage: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioError catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<GenericPagination<ProfessionModel>> getProfession(Filter param) async {
    try {
      final response = await dio.get(
        'CDMS/api/v1.0/business/category/',
        queryParameters: param.toJson(),
        options: Options(
          headers: StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty
              ? {
                  'Authorization':
                      'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
                }
              : {},
        ),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson(
          response.data,
          (p0) => ProfessionModel.fromJson(p0 as Map<String, dynamic>),
        );
      }

      throw ServerException(
        statusCode: response.statusCode ?? 0,
        errorMessage: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioError catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<GenericPagination<CuponModel>> getCoupon(CFilter filter) async {
    try {
      final response = await dio.get(
        'PMS/api/v1.0/business/${StorageRepository.getString(StorageKeys.COMPID)}/coupon/',
        options: Options(
          headers: StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty
              ? {
                  'Authorization':
                      'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
                }
              : {},
        ),
        queryParameters: filter.toJson(),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final List<dynamic> existingData =
            box.get(StorageKeys.CUPONS, defaultValue: []);
        final List<dynamic> newData = response.data['results'];
        final mergedData = List.from(existingData);
        for (final item in newData) {
          final existingItemIndex =
              mergedData.indexWhere((e) => e['id'] == item['id']);
          if (existingItemIndex == -1) {
            mergedData.add(item);
          } else {
            mergedData[existingItemIndex] = item;
          }
        }
        await box.put(StorageKeys.CUPONS, mergedData);
        return GenericPagination.fromJson(
          response.data,
          (p0) => CuponModel.fromJson(p0 as Map<String, dynamic>),
        );
      }
      throw ServerException(
        statusCode: response.statusCode ?? 0,
        errorMessage: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioError catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<GenericPagination<HistoryModel>> getHistory(HFilter filter) async {
    try {
      final response = await dio.get(
        'OMS/api/v1.0/business/${StorageRepository.getString(StorageKeys.COMPID)}/client/${filter.username}/history/product_order/?limit=100&offset=0&status=',
        options: Options(
          headers: StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty
              ? {
                  'Authorization':
                      'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
                }
              : {},
        ),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson(
          response.data,
          (p0) => HistoryModel.fromJson(p0 as Map<String, dynamic>),
        );
      }
      throw ServerException(
        statusCode: response.statusCode ?? 0,
        errorMessage: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioError catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<CuponResModel> postCupon(CuSel param) async {
    try {
      final response = await dio.post(
        'PMS/api/v1.0/business/${StorageRepository.getString(StorageKeys.COMPID)}/coupon/${param.id}/receiver/',
        options: Options(
          headers: StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty
              ? {
                  'Authorization':
                      'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
                }
              : {},
        ),
        data: {"user": param.user},
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return CuponResModel.fromJson(response.data);
      }
      throw ServerException(
        statusCode: response.statusCode ?? 0,
        errorMessage: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioError catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<GenericPagination<RecommendationModel>> getRecommendation(
      String username) async {
    try {
      final response = await dio.get(
        'OMS/api/v1.0/business/${StorageRepository.getString(StorageKeys.COMPID)}/recommendation/?username=$username',
        options: Options(
          headers: StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty
              ? {
                  'Authorization':
                      'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
                }
              : {},
        ),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson(
          response.data,
          (p0) => RecommendationModel.fromJson(p0 as Map<String, dynamic>),
        );
      }
      throw ServerException(
        statusCode: response.statusCode ?? 0,
        errorMessage: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioError catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<CuponModel> getCouponID(int id) {
    throw UnimplementedError();
  }

  @override
  Future<bool> updateOrder(UpdateOrdersModel param) async {
    try {
      final response = await dio.put(
        'OMS/api/v1.0/business/${StorageRepository.getString(StorageKeys.COMPID)}/order/${param.id}/',
        options: Options(
          headers: StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty
              ? {
                  'Authorization':
                      'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
                }
              : {},
        ),
        data: param.toJson(),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return true;
      }
      throw ServerException(
        statusCode: response.statusCode ?? 0,
        errorMessage: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioError catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<CuponResModel> delateCupon(CuSel param) async {
    try {
      final response = await dio.delete(
        'PMS/api/v1.0/business/${StorageRepository.getString(StorageKeys.COMPID)}/coupon/${param.id}/receiver/${param.user}/',
        options: Options(
          headers: StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty
              ? {
                  'Authorization':
                      'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
                }
              : {},
        ),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return CuponResModel.fromJson(response.data);
      }

      throw ServerException(
        statusCode: response.statusCode ?? 0,
        errorMessage: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioError catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }
}
