import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
import 'package:tmed_kiosk/main.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:teledart/teledart.dart';

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
  static String appName = "#TMED_KASSA";

  static TeleDart? telegram;

  // static Future<void> initTele() async {
  //   var botToken = '7175999350:AAHnib0ioHi37o9iEpq2CUlr4oe2pcCCQ6k';
  //   telegram =
  //       TeleDart(botToken, Event((await Telegram(botToken).getMe()).username!));
  // }

//   static void sendMessage(Response response) async {
//     if ((response.statusCode ?? 0) >= 400) {
//       String a = """
// App =>  $appName,
// Status Code => ${response.statusCode}
// Url => !! ${response.realUri.toString()} !!
// Header => ## ${response.headers} ##
// """;
//       if ("${response.data}".length < 100) {
//         a += "\nbody => ${response.data}";
//       }
//       telegram!.sendMessage('@t_med_log', a);
//     }
//   }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
//     telegram?.sendMessage('@t_med_log', """
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
    // sendMessage(response);
    handler.next(response);
  }
}
