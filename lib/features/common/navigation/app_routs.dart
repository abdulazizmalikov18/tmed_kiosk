import 'package:tmed_kiosk/features/auth/presentation/views/auth_main_view.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/v_cart_item.dart';
import 'package:tmed_kiosk/features/category/presentation/controllers/bloc/category_bloc.dart';
import 'package:tmed_kiosk/features/common/navigation/routs_contact.dart';
import 'package:tmed_kiosk/features/common/view/error.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:tmed_kiosk/features/goods/presentation/views/goods_view.dart';

import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:tmed_kiosk/features/main/presentation/views/info_view.dart';
import 'package:tmed_kiosk/features/main/presentation/views/main_view.dart';
import 'package:tmed_kiosk/features/main/presentation/views/profile_view.dart';

import 'package:tmed_kiosk/features/specialists/presentation/controllers/bloc/specialists_bloc.dart';
import 'package:tmed_kiosk/features/specialists/presentation/views/specialists_view.dart';
import 'package:tmed_kiosk/features/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

sealed class AppRouts {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _sectionANavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'sectionANav');
  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: RoutsContact.splash,
    errorBuilder: (context, state) => const ErrorScreen(),
    routes: [
      GoRoute(
        path: RoutsContact.splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: RoutsContact.login,
        builder: (context, state) => const AuthMainView(),
      ),
      GoRoute(
        path: RoutsContact.infoView,
        builder: (context, state) => const InfoView(),
      ),
      GoRoute(
        path: RoutsContact.profile,
        builder: (context, state) => const ProfileView(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => GoodsBloc()),
            BlocProvider(create: (_) => MyNavigatorBloc()),
            BlocProvider(create: (_) => CategoryBloc()),
            BlocProvider(create: (_) => SpecialistsBloc()),
            BlocProvider(create: (_) => CartBloc()),
            BlocProvider(create: (_) => AccountsBloc()),
          ],
          child: MainView(navigationShell: navigationShell),
        ),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _sectionANavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: RoutsContact.goods,
                builder: (context, state) => const GoodsView(),
              ),
              GoRoute(
                path: RoutsContact.cart,
                builder: (context, state) => const VCartItem(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: RoutsContact.specialist,
                builder: (context, state) => const SpecialistsView(),
              ),
            ],
          ),
        ],
      )
    ],
  );
}
