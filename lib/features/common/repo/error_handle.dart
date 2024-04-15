import 'package:dio/dio.dart';
import 'package:tmed_kiosk/core/exceptions/exceptions.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';

class ErrorHandle {
  Future<R> apiCantrol<T, R>(
      {required Future<Response<T>?> Function() request,
      required R Function(T response) body}) async {
    try {
      final response = await request();
      if (response!.statusCode! >= 200 && response.statusCode! < 300) {
        return body(response.data as T);
      }
      throw ServerException(
        statusCode: response.statusCode ?? 0,
        errorMessage: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      Log.e(e);
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      Log.e(e);
      throw ParsingException(errorMessage: e.toString());
    }
  }
}
