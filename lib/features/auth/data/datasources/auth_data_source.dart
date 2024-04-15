// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:tmed_kiosk/core/exceptions/exceptions.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/singletons/dio_settings.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/features/auth/data/model/companiya_list_model.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';

abstract class AuthDataSourche {
  Future<GenericPagination<CompaniyaListModel>> getCompany();
}

class AuthDataSourcheImpl extends AuthDataSourche {
  final dio = serviceLocator<DioSettings>().dio;

  @override
  Future<GenericPagination<CompaniyaListModel>> getCompany() async {
    try {
      final response = await dio.get(
        'BMS/api/v1.0/public/org/',
        options: Options(
          headers: {},
        ),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson(response.data,
            (p0) => CompaniyaListModel.fromJson(p0 as Map<String, dynamic>));
      }
      throw ServerException(
        statusCode: response.statusCode ?? 0,
        errorMessage: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioError {
      throw DioExceptions();
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }
}
