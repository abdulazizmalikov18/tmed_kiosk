import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tmed_kiosk/core/extensions/list_extention.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/features/common/models/kassa_special_model.dart';
import 'package:tmed_kiosk/features/common/models/user.dart';
import 'package:tmed_kiosk/features/common/repo/auth.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  loading,
  cancelLoading,
}

Future<bool> isInternetConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  var connectionChecker = InternetConnectionChecker();
  if (connectivityResult.contains(ConnectivityResult.mobile) ||
      connectivityResult.contains(ConnectivityResult.wifi) ||
      connectivityResult.contains(ConnectivityResult.ethernet) ||
      connectivityResult.contains(ConnectivityResult.vpn) ||
      connectivityResult.contains(ConnectivityResult.bluetooth) &&
          await connectionChecker.hasConnection) {
    return true; // Connected to mobile data or Wi-Fi
  } else {
    return false; // Not connected to the internet
  }
}

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository repository;
  late StreamSubscription<AuthenticationStatus> statusSubscription;
  final box = Hive.box(StorageKeys.PRODUCTS);

  AuthenticationBloc(this.repository)
      : super(const AuthenticationState.unauthenticated()) {
    statusSubscription = repository.authStream.stream.listen((event) {
      add(AuthenticationStatusChanged(status: event));
    });
    on<AuthenticationStatusChanged>((event, emit) async {
      bool hasInternet = await isInternetConnected();
      switch (event.status) {
        case AuthenticationStatus.authenticated:
          if (hasInternet) {
            final userData = await repository.getUser();
            if (userData.isRight) {
              final listSpecial = await repository.getSpecialists();
              if (listSpecial.isRight && listSpecial.right.isNotEmpty) {
                final isHaveSPID = listSpecial.right.findIndex((value) =>
                    value.id == StorageRepository.getString(StorageKeys.SPID));
                await StorageRepository.putString(
                  StorageKeys.COMPID,
                  isHaveSPID != null
                      ? listSpecial.right[isHaveSPID].org.slugName
                      : listSpecial.right.first.org.slugName,
                );
                await StorageRepository.putString(
                  StorageKeys.SPID,
                  isHaveSPID != null
                      ? listSpecial.right[isHaveSPID].id
                      : listSpecial.right.first.id,
                );
                final usertype = MyFunctions.usertype(
                  isHaveSPID != null
                      ? listSpecial.right[isHaveSPID]
                      : listSpecial.right.first,
                );
                usertype.putStorage();
                emit(AuthenticationState.authenticated(
                    userData.right, listSpecial.right));
              } else {
                emit(const AuthenticationState.unauthenticated());
              }
            } else {
              emit(const AuthenticationState.unauthenticated());
            }
          } else {
            emit(const AuthenticationState.unauthenticated());
          }
          break;
        case AuthenticationStatus.unauthenticated:
          emit(const AuthenticationState.unauthenticated());
          break;
        case AuthenticationStatus.loading:
        case AuthenticationStatus.cancelLoading:
          break;
      }
    });

    on<Logout>((event, emit) async {
      final box = Hive.box(StorageKeys.PRODUCTS);
      await StorageRepository.putString(StorageKeys.TOKEN, '');
      await StorageRepository.putBool('isLogged', false);
      await box.clear();
      add(AuthenticationStatusChanged(
          status: AuthenticationStatus.unauthenticated));
    });

    on<ChangeLanguageEvent>((event, emit) async {
      // await StorageRepository.putString(
      //   StorageKeys.LANGUAGE,
      //   event.language,
      // );
      add(AuthenticationStatusChanged(
          status: AuthenticationStatus.authenticated));
    });

    on<LoginUser>((event, emit) async {
      emit(const AuthenticationState.loading());
      final result = await repository.login(
        username: event.userName,
        password: event.password,
      );
      if (result.isRight) {
        await StorageRepository.putBool('isLogged', true);

        add(AuthenticationStatusChanged(
            status: AuthenticationStatus.authenticated));
        event.onSuccess!();
      } else {
        if (event.onError != null) {
          event.onError!((result.left as ServerFailure).errorMessage);
        }
        emit(const AuthenticationState.cancelLoading());
      }
    });

    on<CheckLogin>((event, emit) async {
      var isLogged = StorageRepository.getBool('isLogged');
      if (isLogged) {
        add(AuthenticationStatusChanged(
            status: AuthenticationStatus.authenticated));
      } else {
        add(AuthenticationStatusChanged(
            status: AuthenticationStatus.unauthenticated));
      }
    });

    on<CheckUser>((event, emit) async {
      final hasToken =
          StorageRepository.getString(StorageKeys.TOKEN, defValue: '')
              .isNotEmpty;
      bool hasInternet = await isInternetConnected();
      if (hasToken) {
        if (hasInternet) {
          final response = await repository.getUser();
          if (response.isRight) {
            add(AuthenticationStatusChanged(
                status: AuthenticationStatus.authenticated));
          } else {
            add(RefreshToken());
          }
        } else {
          add(AuthenticationStatusChanged(
              status: AuthenticationStatus.authenticated));
        }
      } else {
        add(AuthenticationStatusChanged(
            status: AuthenticationStatus.unauthenticated));
      }
    });

    on<RefreshToken>((event, emit) async {
      final result = await repository.refreshToken();
      if (result.isRight) {
        add(AuthenticationStatusChanged(
            status: AuthenticationStatus.authenticated));
      } else {
        add(AuthenticationStatusChanged(
            status: AuthenticationStatus.unauthenticated));
      }
    });
  }

  @override
  Future<void> close() {
    statusSubscription.cancel();
    return super.close();
  }
}
