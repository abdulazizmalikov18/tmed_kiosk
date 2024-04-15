// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/core/exceptions/exceptions.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/singletons/dio_settings.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/features/common/models/popular_category_filter.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
import 'package:tmed_kiosk/features/specialists/data/model/spec_cat_model.dart';
import 'package:tmed_kiosk/features/specialists/data/model/specialist_model.dart';
import 'package:tmed_kiosk/features/specialists/data/model/specil_filter.dart';
import 'package:tmed_kiosk/features/specialists/data/model/today_time_table_model.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/day_id.dart';

abstract class SpecialistsDataSource {
  Future<GenericPagination<SpecialistsModel>> getSpecialists(
      SpecialFilter param);
  Future<GenericPagination<SpecCatModel>> getSpecialistCats(Filter param);
  Future<GenericPagination<TodayTimetableModel>> getTimetable(int id);
  Future<TodayTimetableModel> getTimetableDay(DayId param);
}

class SpecialistsDataSourceImpl extends SpecialistsDataSource {
  final dio = serviceLocator<DioSettings>().dio;
  final box = Hive.box(StorageKeys.PRODUCTS);

  @override
  Future<GenericPagination<SpecialistsModel>> getSpecialists(
      SpecialFilter param) async {
    try {
      final response = await dio.get(
        'BMS/api/v1.0/business/org/${StorageRepository.getString(StorageKeys.COMPID)}/specialists/',
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
            box.get(StorageKeys.SPECIALISTS, defaultValue: []);
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
        await box.put(StorageKeys.SPECIALISTS, mergedData);
        await box.put(StorageKeys.SPECIALISTSCOUNT, response.data['count']);
        return GenericPagination.fromJson(response.data,
            (p0) => SpecialistsModel.fromJson(p0 as Map<String, dynamic>));
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
  Future<GenericPagination<SpecCatModel>> getSpecialistCats(
      Filter param) async {
    try {
      final response = await dio.get(
          'BMS/api/v1.0/business/org/${StorageRepository.getString(StorageKeys.COMPID)}/specialist_cats/?limit=1000',
          options: Options(
            headers: StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty
                ? {
                    'Authorization':
                        'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
                  }
                : {},
          ),
          queryParameters: param.toJson());
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final List<dynamic> existingData =
            box.get(StorageKeys.SPECIALCATS, defaultValue: []);
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
        await box.put(StorageKeys.SPECIALCATS, mergedData);
        return GenericPagination.fromJson(response.data,
            (p0) => SpecCatModel.fromJson(p0 as Map<String, dynamic>));
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
  Future<GenericPagination<TodayTimetableModel>> getTimetable(int id) async {
    try {
      final response = await dio.get(
        'BMS/api/v1.0/business/org/${StorageRepository.getString(StorageKeys.COMPID)}/specialist/$id/timetable/',
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
            (p0) => TodayTimetableModel.fromJson(p0 as Map<String, dynamic>));
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
  Future<TodayTimetableModel> getTimetableDay(DayId param) async {
    try {
      final response = await dio.get(
        'BMS/api/v1.0/business/org/${StorageRepository.getString(StorageKeys.COMPID)}/specialist/${param.id}/timetable/${param.day}/',
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
        return TodayTimetableModel.fromJson(response.data);
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
