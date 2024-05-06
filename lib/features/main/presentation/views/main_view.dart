import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:tmed_kiosk/assets/colors/theme_changer.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/category/presentation/controllers/bloc/category_bloc.dart';
import 'package:tmed_kiosk/features/common/controllers/price_bloc/price_bloc.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/navigation/routs_contact.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';
import 'package:tmed_kiosk/features/common/user_type/user_type.dart';
import 'package:tmed_kiosk/features/common/widgets/dialog_title.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/common/widgets/w_textfield.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/main_view_modal.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/v_cart_item.dart';
import 'package:tmed_kiosk/features/common/controllers/internet_bloc/internet_bloc.dart';
import 'package:tmed_kiosk/features/common/widgets/w_scale_animation.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/tts_controller_mixin.dart';
import 'package:tmed_kiosk/features/specialists/presentation/controllers/bloc/specialists_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:visibility_detector/visibility_detector.dart';
// ignore: depend_on_referenced_packages

class MainView extends StatefulWidget {
  const MainView({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with WidgetsBindingObserver {
  TTSControllerMixin controllerMixin = TTSControllerMixin();
  late MainViewModal viewModal;
  late bool visible;
  Timer? _timer;
  Timer? _longPressTimer;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    viewModal.screenController(state, context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    viewModal = MainViewModal();
    context
        .read<PriceBloc>()
        .add(ChangeUserType(userType: UserType.getStorage));

    context.read<GoodsBloc>().add(GetOrgProduct(isOfline: true));
    context.read<CategoryBloc>().add(GetCategory());
    context.read<SpecialistsBloc>().add(GetSpecialists());
    context.read<SpecialistsBloc>().add(GetSpeciaCats());
    context.read<CartBloc>().add(GetProcessStatus());
    context.read<AccountsBloc>().add(GetCupon());
    super.initState();
    controllerMixin.initTts();
    _startTimer();
    WidgetsBinding.instance.addObserver(this);
  }

  void _startTimer() {
    // Start a timer to navigate to the home page after 15 seconds of inactivity
    _timer = Timer(const Duration(seconds: 60), () {
      if (context.read<CartBloc>().state.cartMap.isEmpty) {
        context.go(RoutsContact.infoView);
      }
    });
  }

  void _handleLongPressStart(LongPressStartDetails details) {
    Log.w("_handleLongPressStart");
    _longPressTimer = Timer(const Duration(seconds: 5), () {
      _timer?.cancel();
      Log.w("_handleLongPressStart 2");
      context.push(RoutsContact.profile).then((value) {
        _startTimer();
      });
    });
  }

  void _handleLongPressEnd(LongPressEndDetails details) {
    _longPressTimer?.cancel();
  }

  void _restartTimer() {
    _timer?.cancel();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyNavigatorBloc, MyNavigatorState>(
      builder: (context, state) {
        return VisibilityDetector(
          onVisibilityChanged: (VisibilityInfo info) {
            visible = info.visibleFraction > 0;
          },
          key: const Key('visible-detector-key'),
          child: BarcodeKeyboardListener(
            bufferDuration: const Duration(milliseconds: 200),
            onBarcodeScanned: (barcode) {
              if (!visible) return;

              if (barcode.startsWith("IUUZBAD")) {
                final pnfl = barcode.substring(16, 29);
                TextEditingController controller =
                    TextEditingController(text: pnfl);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const DialogTitle(title: "Shu sizning pnfelingizmi"),
                    content: Column(
                      children: [
                        WTextField(
                          controller: controller,
                          onChanged: (value) {},
                        ),
                        WButton(
                          onTap: () {
                            context.read<AccountsBloc>().add(AccountsGet(
                                  search: controller.text,
                                  onSucces: () {
                                    context.read<AccountsBloc>().add(GetCupon(
                                        user: context
                                            .read<AccountsBloc>()
                                            .state
                                            .selectAccount
                                            .selectAccount
                                            .username));
                                    context.push(
                                      RoutsContact.cart,
                                      extra: true,
                                    );
                                  },
                                  onError: () {
                                    context.read<ShowPopUpBloc>().add(ShowPopUp(
                                        message: "User Topilmadi",
                                        status: PopStatus.error));
                                  },
                                ));
                          },
                        )
                      ],
                    ),
                  ),
                );
                context.read<AccountsBloc>().add(
                    AccountsGet(search: pnfl, onSucces: () {}, onError: () {}));
                context.read<AccountsBloc>().add(IsFocused(isFocused: true));
                context.read<MyNavigatorBloc>().add(NavId(6));
              }
            },
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Log.w("onTap");
                _restartTimer();
              },
              onVerticalDragDown: (details) {
                Log.w("onVerticalDragDown");
                _restartTimer();
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).viewPadding.top),
                  child: widget.navigationShell,
                ),
                bottomNavigationBar: BlocBuilder<InternetBloc, InternetState>(
                  builder: (context, stateInternet) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onLongPressStart: _handleLongPressStart,
                          onLongPressEnd: _handleLongPressEnd,
                          child: BottomNavigationBar(
                            showUnselectedLabels: false,
                            showSelectedLabels: false,
                            backgroundColor: context.color.contColor,
                            selectedItemColor: green,
                            elevation: 10,
                            type: BottomNavigationBarType.fixed,
                            currentIndex: widget.navigationShell.currentIndex,
                            onTap: (value) {
                              widget.navigationShell.goBranch(
                                value,
                                initialLocation: value ==
                                    widget.navigationShell.currentIndex,
                              );
                            },
                            items: [
                              BottomNavigationBarItem(
                                activeIcon: AppIcons.home.svg(color: blue),
                                icon: AppIcons.home.svg(color: greyText),
                                label: "Niumadir",
                              ),
                              BottomNavigationBarItem(
                                activeIcon: AppIcons.personend.svg(color: blue),
                                icon: AppIcons.personend.svg(color: greyText),
                                label: "Niumadir",
                              ),
                            ],
                          ),
                        ),
                        BlocBuilder<PriceBloc, PriceState>(
                          builder: (context, state) {
                            return WButton(
                              margin: const EdgeInsets.only(
                                  left: 16, top: 10, bottom: 10),
                              height: 40,
                              width: 40,
                              borderRadius: 12,
                              onTap: () {
                                context.read<PriceBloc>().add(
                                    ModeControllerEvent(
                                        themeMode: !state.isMode));
                                AppScope.update(
                                  context,
                                  AppScope(
                                      themeMode:
                                          AppScope.of(context).themeMode ==
                                                  ThemeMode.light
                                              ? ThemeMode.dark
                                              : ThemeMode.light),
                                );
                              },
                              color: context.color.white.withOpacity(.1),
                              child: state.isMode
                                  ? AppIcons.icMoon.svg(color: greyText)
                                  : AppIcons.icSun.svg(color: orang),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
                // floatingActionButton: BlocBuilder<PriceBloc, PriceState>(
                //   builder: (context, state) {
                //     return WButton(
                //       height: 40,
                //       width: 40,
                //       borderRadius: 12,
                //       onTap: () {
                //         context
                //             .read<PriceBloc>()
                //             .add(ModeControllerEvent(themeMode: !state.isMode));
                //         AppScope.update(
                //           context,
                //           AppScope(
                //               themeMode:
                //               AppScope.of(context).themeMode == ThemeMode.light
                //                   ? ThemeMode.dark
                //                   : ThemeMode.light),
                //         );
                //       },
                //       color: context.color.white.withOpacity(.1),
                //       child: state.isMode
                //           ? AppIcons.icMoon.svg(color: greyText)
                //           : AppIcons.icSun.svg(color: orang),
                //     );
                //   },
                // ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CartViewKiosk extends StatelessWidget {
  const CartViewKiosk({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MyNavigatorBloc, MyNavigatorState, bool>(
      selector: (state) => state.openCart,
      builder: (context, openCart) {
        return AnimatedContainer(
          height: double.infinity,
          curve: Curves.easeIn,
          width: openCart ? MediaQuery.of(context).size.width / 2 - 32 : 64,
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            border: Border.all(color: white.withOpacity(.1)),
            color: contColor,
          ),
          child: openCart
              ? const VCartItem(isAccount: false)
              : WScaleAnimation(
                  onTap: () {
                    context.read<MyNavigatorBloc>().add(OpenCart(!openCart));
                  },
                  child: DecoratedBox(
                    decoration: const BoxDecoration(color: contColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RotatedBox(
                          quarterTurns: 3,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppIcons.shoppingCart.svg(
                                color: blue,
                                height: 32,
                                width: 32,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "card".tr(),
                                style:
                                    AppTheme.displayLarge.copyWith(color: blue),
                              ),
                              if (context
                                  .watch<CartBloc>()
                                  .state
                                  .cartMap
                                  .isNotEmpty)
                                const SizedBox(width: 12),
                              if (context
                                  .watch<CartBloc>()
                                  .state
                                  .cartMap
                                  .isNotEmpty)
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: blue,
                                  child: Text(
                                    "${context.watch<CartBloc>().state.cartMap.length}",
                                    style: AppTheme.labelLarge
                                        .copyWith(color: white),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
