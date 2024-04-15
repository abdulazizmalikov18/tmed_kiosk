// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/core/exceptions/exceptions.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';
import 'package:tmed_kiosk/features/goods/data/datasources/goods_datasource.dart';
import 'package:tmed_kiosk/features/goods/data/model/goods_query_parameters.dart';
import 'package:tmed_kiosk/features/goods/data/model/org_product_model.dart';
import 'package:tmed_kiosk/features/goods/data/model/supplies_model.dart';
import 'package:tmed_kiosk/features/main/data/model/product_special.dart';

class GoodsLocalDataSource extends GoodsDataSource {
  final box = Hive.box(StorageKeys.PRODUCTS);
  @override
  Future<GenericPagination<OrgProductModel>> getOrgProduct(
      GoodsQueryParam param) async {
    bool isSort = false;
    try {
      List<dynamic> usersJson = box.get(StorageKeys.PRODUCT, defaultValue: []);
      int count = box.get(StorageKeys.PRODUCTCOUNT, defaultValue: 0);
      List<OrgProductModel> orgProducts = usersJson.map((value) {
        final json = jsonEncode(value);
        final map = jsonDecode(json);
        return OrgProductModel.fromJson(map);
      }).toList();
      if (param.specialist != null) {
        isSort = true;
        orgProducts = orgProducts
            .where(
                (element) => element.specialistIds.contains(param.specialist))
            .toList();
      }
      if (param.group != null) {
        isSort = true;
        orgProducts = orgProducts.where((element) {
          for (var element in element.groups) {
            return element.group == param.group;
          }
          return false;
        }).toList();
      }
      if (param.search != null) {
        isSort = true;
        orgProducts = orgProducts
            .where((element) => element.product.name
                .toLowerCase()
                .contains(param.search!.toLowerCase()))
            .toList();
      }
      final pagination = GenericPagination<OrgProductModel>(
        count: isSort ? orgProducts.length : count,
        results: orgProducts,
      );
      return pagination;
    } on ServerException {
      rethrow;
    } on DioError {
      throw DioExceptions();
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<OrgProductModel> getOrgProductID(int param) async {
    try {
      List<dynamic> usersJson = box.get(StorageKeys.PRODUCT, defaultValue: []);
      List<OrgProductModel> orgProducts = usersJson.map((value) {
        final json = jsonEncode(value);
        final map = jsonDecode(json);
        return OrgProductModel.fromJson(map);
      }).toList();
      final product = orgProducts.where((element) => element.id == param);
      if (product.isEmpty) {
        throw ServerFailure(errorMessage: "Malumot yo'q", statusCode: 200);
      }
      return product.first;
    } on ServerException {
      rethrow;
    } on DioError {
      throw DioExceptions();
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<GenericPagination<ProductSpecialModel>> getPSp(int id) {
    throw UnimplementedError();
  }

  @override
  Future<OrgProductModel> getProductBarCode(String param) async {
    try {
      List<dynamic> usersJson = box.get(StorageKeys.PRODUCT);
      List<OrgProductModel> orgProducts = usersJson.map((value) {
        final json = jsonEncode(value);
        final map = jsonDecode(json);
        return OrgProductModel.fromJson(map);
      }).toList();
      final product = orgProducts.where((element) => element.barCode == param);
      if (product.isEmpty) {
        throw const ServerException(
            errorMessage: "Malumot yo'q", statusCode: 0);
      }
      return product.first;
    } on ServerException {
      rethrow;
    } on DioError {
      throw DioExceptions();
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<GenericPagination<SuppliesModel>> getSupplies(int id) async {
    try {
      List<dynamic> usersJson = box.get(StorageKeys.SUPPLIES, defaultValue: []);
      List<SuppliesModel> supplies = usersJson.map((value) {
        final json = jsonEncode(value);
        final map = jsonDecode(json);
        return SuppliesModel.fromJson(map);
      }).toList();
      supplies = supplies.where((element) => element.product == id).toList();
      final pagination = GenericPagination<SuppliesModel>(
        results: supplies,
        count: supplies.length,
      );
      return pagination;
    } on ServerException {
      rethrow;
    } on DioError {
      throw DioExceptions();
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<List<OrgProductModel>> getOrgProductIDList(List<int> param) async {
    try {
      List<dynamic> usersJson = box.get(StorageKeys.PRODUCT, defaultValue: []);
      List<OrgProductModel> products = [];
      List<OrgProductModel> orgProducts = usersJson.map((value) {
        final json = jsonEncode(value);
        final map = jsonDecode(json);
        return OrgProductModel.fromJson(map);
      }).toList();
      for (var value in param) {
        try {
          final product =
              orgProducts.firstWhere((element) => element.id == value);
          products.add(product);
        } catch (e) {
          if (kDebugMode) {
            print("================>>>>>>>>>>>>> Nima bop ketti $e");
          }
        }
      }

      return products;
    } on ServerException {
      rethrow;
    } on DioError {
      throw DioExceptions();
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }
}
