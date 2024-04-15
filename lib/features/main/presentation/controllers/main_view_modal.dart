// import 'package:tmed_kiosk/features/orders/presentation/controllers/bloc/orders_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tmed_kiosk/features/main/presentation/controllers/order_socet/socket_offer_bloc.dart';

import 'package:flutter/material.dart';

class MainViewModal {
  bool isDisconnection = false;
  Future<void> screenController(
      AppLifecycleState state, BuildContext context) async {
    switch (state) {
      case AppLifecycleState.paused: // screen off/navigate away
        {
          break;
        }
      case AppLifecycleState.resumed:
        {
          // if (!context.read<SocketOfferBloc>().state.isConnect) {
          //   context.read<OrdersBloc>().add(GetOrders(isLoading: false));
          // }
          // if (!isDisconnection) {
          //   context.read<SocketOfferBloc>().add(ConnectSocketEvent((model) {
          //     context.read<OrdersBloc>().add(GetSoket(model: model));
          //   }));
          //   isDisconnection = true;
          // }
          break;
        } // screen on/navigate to
      case AppLifecycleState.inactive: // screen off/navigate away
        {
          break;
        }
      case AppLifecycleState.detached:
        {
          break;
        }
      case AppLifecycleState.hidden:
        {
          // Future.delayed(const Duration(minutes: 1), () {
          //   if (true) {
          //     context.read<SocketOfferBloc>().add(DisConnectSocketEvent());
          //     isDisconnection = false;
          //   }
          // }).whenComplete(() {});
          break;
        }
    }
  }
}
