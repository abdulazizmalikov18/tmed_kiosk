import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tmed_kiosk/assets/colors/theme_changer.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/utils/enums.dart';
import 'package:tmed_kiosk/core/utils/size_config.dart';
import 'package:tmed_kiosk/features/common/controllers/price_bloc/price_bloc.dart';
import 'package:tmed_kiosk/features/common/navigation/app_routs.dart';
import 'package:tmed_kiosk/features/common/navigation/routs_contact.dart';
import 'package:tmed_kiosk/features/common/widgets/custom_screen.dart';
import 'package:flutter/rendering.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/features/common/controllers/auth/authentication_bloc.dart';
import 'package:tmed_kiosk/features/common/controllers/internet_bloc/internet_bloc.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/repo/auth.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tmed_kiosk/restart_widget.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

String appVersion = "1.0.0.6";
const AppType $appType = AppType.TMED;
const AppUrl $appUrl = AppUrl.GLOBAL;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // await ErrorHandlerInterceptor.initTele();
  setupLocator();
  await StorageRepository.getInstance();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox(StorageKeys.PRODUCTS);
  debugRepaintRainbowEnabled = false;
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('uz'),
        Locale('ru'),
        Locale('en'),
      ],
      path: 'lib/assets/strings',
      fallbackLocale: const Locale('uz'),
      startLocale: const Locale('uz'),
      // assetLoader: const CodegenLoader(),
      child: DependencyScope(
        initialModel: AppScope(
          themeMode: StorageRepository.getBool(StorageKeys.THEMEISDARK)
              ? ThemeMode.light
              : ThemeMode.dark,
        ),
        child: const RestartWidget(
          child: AppProvider(),
        ),
      ),
    ),
  );
}

class AppProvider extends StatefulWidget {
  const AppProvider({super.key});

  @override
  State<AppProvider> createState() => _AppProviderState();
}

class _AppProviderState extends State<AppProvider> {
  late InternetBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = InternetBloc();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: bloc,
        child: const MyApp(),
      );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  InternetBloc bloc = InternetBloc();

  @override
  void initState() {
    bloc = InternetBloc();
    Connectivity().onConnectivityChanged.listen((status) async {
      bloc.add(GlobalCheck(isConnected: await isInternetConnected()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (c) => bloc),
        BlocProvider(
            create: (_) =>
                AuthenticationBloc(AuthRepository())..add(CheckUser())),
        BlocProvider(create: (_) => ShowPopUpBloc()),
        BlocProvider(create: (_) => PriceBloc()..add(const InitPrice())),
      ],
      child: MaterialApp.router(
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        title: $appType.appTitle,
        debugShowCheckedModeBanner: false,
        darkTheme: AppTheme.darkTheme(),
        themeMode: AppScope.of(context).themeMode,
        theme: AppTheme.lightTheme(),
        routerConfig: AppRouts.router,
        builder: (context, child) {
          SizeConfig().init(context);
          return CustomScreen(
            child: BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                debugPrint('STATE LISTENER ============> ${state.status}');
                switch (state.status) {
                  case AuthenticationStatus.unauthenticated:
                    AppRouts.router.pushReplacement(RoutsContact.login);
                    break;
                  case AuthenticationStatus.authenticated:
                    AppRouts.router.go(RoutsContact.category);
                    break;
                  case AuthenticationStatus.loading:
                  case AuthenticationStatus.cancelLoading:
                    break;
                }
              },
              child: child,
            ),
          );
        },
      ),
    );
  }
}
