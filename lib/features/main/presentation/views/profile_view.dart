import 'package:kiosk_mode/kiosk_mode.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/process_status_entity.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/common/controllers/price_bloc/price_bloc.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/selection_account.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/singletons/dio_settings.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/features/common/controllers/auth/authentication_bloc.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/lenguage_sele.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.cartBloc});
  final CartBloc cartBloc;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String lenguage = StorageRepository.getString('language');
  late final Stream<KioskMode> _currentMode = watchKioskMode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        title: const Text("Profile"),
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(160),
                  child: Container(
                    height: 140,
                    width: 140,
                    color: greyText,
                    child: Image.network(
                      state.user.avatar,
                      fit: BoxFit.cover,
                      errorBuilder: (context, url, error) => const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.person, color: white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '${state.user.name} ${state.user.lastname} ${state.user.surname}',
                  style: AppTheme.bodyLarge.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    state.user.mainCat.name,
                    style: AppTheme.labelSmall.copyWith(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                DecoratedBox(
                  decoration: wdecoration,
                  child: ListTile(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        useRootNavigator: true,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (builder) => SelectionAccountDialog(
                            listSpecial: state.listSpecial),
                      );
                    },
                    leading: AppIcons.personend.svg(color: white50),
                    title: const Text("Показать деньги"),
                    trailing: AppIcons.arrowRight.svg(color: white50),
                  ),
                ),
                const SizedBox(height: 8),
                DecoratedBox(
                  decoration: wdecoration,
                  child: BlocBuilder<PriceBloc, PriceState>(
                    builder: (context, state) {
                      return ListTile(
                        leading: AppIcons.wallet.svg(),
                        title: const Text("Показать деньги"),
                        trailing: CupertinoSwitch(
                          activeColor: blue,
                          value: state.isPrice,
                          onChanged: (value) {
                            context.read<PriceBloc>().add(const ChangePrise());
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                DecoratedBox(
                  decoration: wdecoration,
                  child: StreamBuilder(
                    stream: _currentMode,
                    builder: (context, snapshot) {
                      final mode = snapshot.data;
                      final message = mode == null
                          ? 'Can\'t determine the mode'
                          : 'Current mode: $mode';
                      return ListTile(
                        leading: AppIcons.wallet.svg(),
                        title: Text(message),
                        trailing: CupertinoSwitch(
                          activeColor: blue,
                          value: mode == KioskMode.enabled,
                          onChanged: (value) {
                            if (value) {
                              startKioskMode();
                            } else {
                              stopKioskMode();
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                DecoratedBox(
                  decoration: wdecoration,
                  child: ListTile(
                    onTap: () async {
                      showModalBottomSheet(
                        context: context,
                        useRootNavigator: true,
                        backgroundColor: Colors.transparent,
                        builder: (builder) => SelectLenguage(
                          selection: lenguage == 'uz' ? 0 : 1,
                        ),
                      ).then((value) async {
                        if (value is String) {
                          await context.setLocale(Locale(value.toString()));
                          lenguage = value.toString();
                          setState(() {});
                          await StorageRepository.putString(
                              'language', value.toString());

                          serviceLocator<DioSettings>()
                              .setBaseOptions(lang: value);
                          await resetLocator();
                        }
                      });
                    },
                    leading: AppIcons.languageSquare.svg(),
                    title: Text(LocaleKeys.profile_language.tr()),
                    trailing: AppIcons.arrowRight.svg(color: white50),
                  ),
                ),
                const SizedBox(height: 8),
                BlocBuilder<CartBloc, CartState>(
                  bloc: widget.cartBloc,
                  builder: (context, state) {
                    return Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: context.color.contColor,
                        border: Border.all(color: contColor.withOpacity(0.1)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButtonFormField<ProcessStatusEntity>(
                        value: state.selStatus,
                        icon: AppIcons.arrowDown.svg(),
                        decoration: InputDecoration(
                          fillColor: context.color.contColor,
                          focusColor: context.color.contColor,
                          hoverColor: context.color.contColor,
                          border: InputBorder.none,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        dropdownColor: context.color.contColor,
                        items: state.processStatus
                            .map((ProcessStatusEntity value) {
                          return DropdownMenuItem<ProcessStatusEntity>(
                            value: value,
                            child: Text(
                              value.name,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.labelSmall.copyWith(
                                  color: context.color.white.withOpacity(.4)),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          StorageRepository.putInt(
                              StorageKeys.STATUS, newValue!.id);
                          context
                              .read<CartBloc>()
                              .add(SelStatus(selStatus: newValue));
                        },
                      ),
                    );
                  },
                ),
                const Spacer(),
                WButton(
                  color: red,
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIcons.logout.svg(),
                      const SizedBox(width: 12),
                      Text(
                        LocaleKeys.profile_exit.tr(),
                        style: AppTheme.bodyLarge
                            .copyWith(fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  onTap: () {
                    logoutDialog(context);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> logoutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        contentPadding: const EdgeInsets.all(16),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Center(
                    child: Text(
                      "Выйти из профиля",
                      style: AppTheme.displaySmall
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(1, 1),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: AppIcons.closeCircle.svg(),
                    ),
                  )
                ],
              ),
              const Text(
                "Вы уверены, что хотите выйти из своего профиля?",
                style: AppTheme.labelLarge,
              ),
              const SizedBox(height: 16),
              WButton(
                text: "Выйти",
                height: 40,
                color: red,
                onTap: () {
                  context.read<AuthenticationBloc>().add(Logout());
                },
              ),
              const SizedBox(height: 8),
              WButton(
                text: "Отмена",
                height: 40,
                color: blue.withOpacity(.5),
                border: Border.all(color: red),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
