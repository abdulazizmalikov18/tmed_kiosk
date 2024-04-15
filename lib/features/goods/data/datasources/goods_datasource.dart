// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/core/exceptions/exceptions.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/singletons/dio_settings.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
import 'package:tmed_kiosk/features/goods/data/model/goods_query_parameters.dart';
import 'package:tmed_kiosk/features/goods/data/model/org_product_model.dart';
import 'package:tmed_kiosk/features/goods/data/model/supplies_model.dart';
import 'package:tmed_kiosk/features/main/data/model/product_special.dart';

abstract class GoodsDataSource {
  Future<GenericPagination<OrgProductModel>> getOrgProduct(
      GoodsQueryParam param);
  Future<OrgProductModel> getProductBarCode(String param);
  Future<OrgProductModel> getOrgProductID(int param);
  Future<List<OrgProductModel>> getOrgProductIDList(List<int> param);
  Future<GenericPagination<SuppliesModel>> getSupplies(int id);
  Future<GenericPagination<ProductSpecialModel>> getPSp(int id);
}

class GoodsDataSourceImpl extends GoodsDataSource {
  final dio = serviceLocator<DioSettings>().dio;
  final box = Hive.box(StorageKeys.PRODUCTS);
  @override
  Future<List<OrgProductModel>> getOrgProductIDList(List<int> param) {
    throw UnimplementedError();
  }

  @override
  Future<GenericPagination<OrgProductModel>> getOrgProduct(
      GoodsQueryParam param) async {
    try {
      final response = await dio.get(
        'PMS/api/v1.0/business/${StorageRepository.getString(StorageKeys.COMPID)}/org-product/',
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
        if (param.group == null) {
          final List<dynamic> existingData =
              box.get(StorageKeys.PRODUCT, defaultValue: []);
          final List<dynamic> newData = response.data['results'];
          final mergedData = List.from(existingData);
          int index = 0;
          for (final item in newData) {
            final existingItemIndex =
                mergedData.indexWhere((e) => e['id'] == item['id']);
            if (existingItemIndex == -1) {
              mergedData.insert(index, item);
            } else {
              mergedData[existingItemIndex] = item;
            }
            index += 1;
          }
          await box.put(StorageKeys.PRODUCT, mergedData);
          await box.put(StorageKeys.PRODUCTCOUNT, response.data['count']);
        }
        return GenericPagination.fromJson(response.data,
            (p0) => OrgProductModel.fromJson(p0 as Map<String, dynamic>));
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
  Future<GenericPagination<SuppliesModel>> getSupplies(int id) async {
    try {
      final response = await dio.get(
        'PMS/api/v1.0/business/${StorageRepository.getString(StorageKeys.COMPID)}/supplies/?product=$id',
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
            box.get(StorageKeys.SUPPLIES, defaultValue: []);
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
        await box.put(StorageKeys.SUPPLIES, mergedData);
        return GenericPagination.fromJson(response.data,
            (p0) => SuppliesModel.fromJson(p0 as Map<String, dynamic>));
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
  Future<GenericPagination<ProductSpecialModel>> getPSp(int id) async {
    try {
      final response = await dio.get(
        'PMS/api/v1.0/business/${StorageRepository.getString(StorageKeys.COMPID)}/product/$id/specialist/?limit=100',
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
        return GenericPagination.fromJson(response.data,
            (p0) => ProductSpecialModel.fromJson(p0 as Map<String, dynamic>));
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
  Future<OrgProductModel> getOrgProductID(int param) async {
    try {
      final response = await dio.get(
        'PMS/api/v1.0/business/${StorageRepository.getString(StorageKeys.COMPID)}/org-product/$param/',
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
        return OrgProductModel.fromJson(response.data);
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
  Future<OrgProductModel> getProductBarCode(String param) async {
    try {
      final response = await dio.get(
        'PMS/api/v1.0/business/${StorageRepository.getString(StorageKeys.COMPID)}/org-product/$param/bar-code/',
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
        return OrgProductModel.fromJson(response.data);
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
