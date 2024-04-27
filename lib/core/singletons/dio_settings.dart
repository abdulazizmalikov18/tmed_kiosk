import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/features/common/repo/auth.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
import 'package:tmed_kiosk/main.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import 'package:teledart/teledart.dart';

class DioSettings {
  BaseOptions _dioBaseOptions = BaseOptions(
    baseUrl: $appUrl.baseUrl,
    connectTimeout: const Duration(milliseconds: 35000),
    receiveTimeout: const Duration(milliseconds: 35000),
    followRedirects: false,
    headers: <String, dynamic>{
      'Accept-Language': StorageRepository.getString(
        StorageKeys.LANGUAGE,
        defValue: 'uz',
      ),
    },
    validateStatus: (status) => status != null && status <= 500,
  );

  void setBaseOptions({String? lang}) {
    _dioBaseOptions = BaseOptions(
      baseUrl: $appUrl.baseUrl,
      connectTimeout: const Duration(milliseconds: 35000),
      receiveTimeout: const Duration(milliseconds: 35000),
      headers: <String, dynamic>{'Accept-Language': lang},
      followRedirects: false,
      validateStatus: (status) => status != null && status <= 500,
    );
  }

  BaseOptions get dioBaseOptions => _dioBaseOptions;

  bool get chuck =>
      StorageRepository.getBool(StorageKeys.CHUCK, defValue: false);

  Dio get dio => Dio(_dioBaseOptions)
    ..interceptors.addAll(
      [
        PrettyDioLogger(
          requestBody: kDebugMode,
          request: kDebugMode,
          requestHeader: kDebugMode,
          responseBody: kDebugMode,
          responseHeader: kDebugMode,
          error: kDebugMode,
        ),
        ErrorHandlerInterceptor(),
      ],
    );
}

class ErrorHandlerInterceptor implements Interceptor {
  ErrorHandlerInterceptor._();

  static final _instance = ErrorHandlerInterceptor._();

  factory ErrorHandlerInterceptor() => _instance;
  static String appName = "#TMED_TASK";

  static void sendMessage(Response response) async {
//     if ((response.statusCode ?? 0) >= 400) {
//       String a = """
// App =>  $appName,
// Version =>  $appVersion,
// UserName =>  ${StorageRepository.getString(StorageKeys.USERNAME)},
// Device =>  ${Platform.localeName},
// Status Code => ${response.statusCode}
// Url => !! ${response.realUri.toString()} !!
// Header => ## ${response.headers} ##
// """;
//       if ("body => @@ ${response.data} @@".length < 100) {
//         a += "\nbody => @@ ${response.data} @@";
//       }
//       // TelegramSender.sendMessage(TelegramChannel.logChannel, a);
//     }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
//     TelegramSender.sendMessage(TelegramChannel.logChannel, """
// #error
// Error ##################
// App => $appName
// Url => !! ${err.requestOptions.uri.toString()} !!
// Header => ## ${err.requestOptions.headers} ##
// body => @@ ${err.requestOptions.data} @@
// error => ${err.error},
// Message => ${err.message},
// """);
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 401) {
      final result = await AuthRepository().refreshToken();

      if (result.isRight) {
        await StorageRepository.putString(
            StorageKeys.TOKEN, result.right.access);
        await StorageRepository.putString(
            StorageKeys.REFRESH, result.right.refresh);
        return handler.resolve(await serviceLocator<DioSettings>()
            .dio
            .fetch(response.requestOptions
              ..headers = {
                "Authorization": "Bearer ${result.right.access}",
              }));
      } else {
        return handler.next(response);
      }
    }
    sendMessage(response);
    handler.next(response);
  }
}
