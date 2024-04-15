// ignore_for_file: deprecated_member_use
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/core/exceptions/exceptions.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/singletons/dio_settings.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/features/category/data/model/category_model.dart';
import 'package:tmed_kiosk/features/category/data/model/catigory_filter_model.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';

abstract class CatrgoryDataSource {
  Future<GenericPagination<CategoryModel>> categoryList(CatigoryFilter param);
}

class CatrgoryDataSourceImpl extends CatrgoryDataSource {
  final dio = serviceLocator<DioSettings>().dio;
  final box = Hive.box(StorageKeys.PRODUCTS);

  @override
  Future<GenericPagination<CategoryModel>> categoryList(
      CatigoryFilter param) async {
    try {
      final response = await dio.get(
        'PMS/api/v1.0/business/${StorageRepository.getString(StorageKeys.COMPID)}/product_group/',
        options: Options(
          headers: StorageRepository.getString('token').isNotEmpty
              ? {
                  'Authorization':
                      'Bearer ${StorageRepository.getString('token')}'
                }
              : {},
        ),
        queryParameters: param.toJson(),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final List<dynamic> existingData =
            box.get(StorageKeys.CATIGORY, defaultValue: []);
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
        await box.put(StorageKeys.CATIGORY, mergedData);
        return GenericPagination.fromJson(
          response.data,
          (p0) => CategoryModel.fromJson(p0 as Map<String, dynamic>),
        );
      }
      if (response.statusCode! >= 400 && response.statusCode! < 500) {
        return GenericPagination<CategoryModel>(results: []);
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
