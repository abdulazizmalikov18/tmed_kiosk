// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/core/exceptions/exceptions.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/common/controllers/auth/authentication_bloc.dart';
import 'package:tmed_kiosk/features/common/models/kassa_special_model.dart';

import 'package:tmed_kiosk/features/common/models/token_model.dart';
import 'package:tmed_kiosk/features/common/models/user.dart';
import 'package:tmed_kiosk/features/common/repo/global_request_repository.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';

class AuthRepository {
  final GlobalRequestRepository repo = GlobalRequestRepository();
  final StreamController<AuthenticationStatus> authStream =
      StreamController.broadcast(sync: true);

  Future<Either<Failure, UserModel>> getUser() async {
    final result = await repo.getSingle(
      endpoint: 'UMS/api/v1.0/account/',
      fromJson: UserModel.fromJson,
    );
    return result;
  }

  Future<Either<Failure, List<KassaSpecialModel>>> getSpecialists() async {
    final result = await repo.getList(
      endpoint: 'UMS/api/v1.0/account/specialists/',
      fromJson: KassaSpecialModel.fromJson,
    );
    return result;
  }

  Future<Either<Failure, UserModel>> putUser(
      {required int id, required String cardNumber}) async {
    final result = await repo.putSingle(
      endpoint: 'employee/$id',
      fromJson: UserModel.fromJson,
      data: {"card_number": cardNumber},
    );
    return result;
  }

  Future<Either<Failure, TokenModel>> refreshToken() async {
    final result = await repo.postAndSingle(
      endpoint: 'UMS/api/v1.0/account/refresh-token/',
      fromJson: TokenModel.fromJson,
      sendToken: false,
      data: {
        'refresh':
            StorageRepository.getString(StorageKeys.REFRESH, defValue: ''),
      },
    );
    if (result.isRight) {
      await StorageRepository.putString(StorageKeys.TOKEN, result.right.access);
      await StorageRepository.putString(
          StorageKeys.REFRESH, result.right.refresh);
      return Right(result.right);
    } else {
      return Left(result.left);
    }
  }

  Future<Either<Failure, TokenModel>> login({
    required String username,
    required String password,
  }) async {
    try {
      final result = await repo.postAndSingle<TokenModel>(
        endpoint: 'UMS/api/v1.0/account/auth/?login_params=username_password',
        fromJson: TokenModel.fromJson,
        sendToken: false,
        data: {
          'username': username,
          'password': password,
        },
      );
      if (result.isRight) {
        await StorageRepository.putString(
          StorageKeys.TOKEN,
          result.right.access,
        );
        await StorageRepository.putString(
          StorageKeys.REFRESH,
          result.right.refresh,
        );
        return Right(result.right);
      } else {
        return Left(result.left);
      }
    } on ServerException {
      rethrow;
    } on DioError {
      throw DioExceptions();
    } on Exception catch (e) {
      throw ParsingException(errorMessage: '$e catch error');
    }
  }
}
