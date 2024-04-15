import 'package:tmed_kiosk/features/common/controllers/price_bloc/price_bloc.dart';
import 'package:tmed_kiosk/features/common/navigation/app_routs.dart';
import 'package:tmed_kiosk/features/common/navigation/routs_contact.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/singletons/dio_settings.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/features/common/controllers/auth/authentication_bloc.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:tmed_kiosk/restart_widget.dart';

import '../../../../assets/constants/icons.dart';
import '../../../../assets/constants/images.dart';

class ProfileSettingsDialog extends StatefulWidget {
  final BuildContext parentContext;

  const ProfileSettingsDialog({super.key, required this.parentContext});

  @override
  State<ProfileSettingsDialog> createState() => _ProfileSettingsDialogState();
}

class _ProfileSettingsDialogState extends State<ProfileSettingsDialog> {
  bool customTileExpanded = false;
  bool selectColor = false;
  Map<String, dynamic> languages = {
    LocaleKeys.languageUz.tr(): AppImages.uzFlag,
    LocaleKeys.languageRu.tr(): AppImages.ruFlag,
  };
  final all = [const Locale('uz'), const Locale('ru')];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1,
          color: white.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      surfaceTintColor: Colors.transparent,
      backgroundColor: backGroundColor,
      alignment: const Alignment(-0.92, 1),
      contentPadding: const EdgeInsets.all(16),
      content: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 232,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Settings Button
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Container(
                        height: 80,
                        width: 80,
                        color: greyText,
                        child: state.listSpecial.isNotEmpty
                            ? Image.network(
                                state.listSpecial.first.avatar,
                                fit: BoxFit.cover,
                                errorBuilder: (context, url, error) =>
                                    const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(Icons.person, color: white),
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${state.user.name} ${state.user.lastname}',
                            style: AppTheme.displayLarge.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.user.mainCat.name,
                            style: AppTheme.labelSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.user.region.name,
                            style: AppTheme.labelSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            const Divider(),

            /// Language Button
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ExpansionTile(
                  backgroundColor: Colors.transparent,
                  collapsedBackgroundColor: Colors.transparent,
                  tilePadding: const EdgeInsets.symmetric(horizontal: 8),
                  title: Row(
                    children: [
                      Image.asset(
                        switch (context.locale.languageCode) {
                          "uz" => AppImages.uzFlag,
                          "ru" => AppImages.ruFlag,
                          _ => AppImages.engFlag,
                        },
                        height: 16,
                        width: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        switch (context.locale.languageCode) {
                          "uz" => LocaleKeys.languageUz.tr(),
                          "ru" => LocaleKeys.languageRu.tr(),
                          _ => LocaleKeys.languageEn.tr(),
                        },
                        style: AppTheme.bodySmall.copyWith(color: white50),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    customTileExpanded
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: white.withOpacity(.5),
                  ),
                  children: [
                    ...List.generate(
                      languages.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: WLanguageButton(
                          onTap: () {
                            context
                                .setLocale(Locale(all[index].toString()))
                                .then((value) {
                              EasyLocalization.ensureInitialized()
                                  .then((value) {
                                StorageRepository.putString(
                                        'language', all[index].toString())!
                                    .then((value) async {
                                  serviceLocator<DioSettings>().setBaseOptions(
                                      lang: all[index].toString());
                                  await resetLocator().then((value) =>
                                      AppRouts.router.go(RoutsContact.goods));
                                });
                              });
                            });
                          },
                          isActive: context.locale.languageCode ==
                              all[index].languageCode,
                          image: languages.values.elementAt(index),
                          text: languages.keys.elementAt(index),
                        ),
                      ),
                    ),
                  ],
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      customTileExpanded = expanded;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 4),

            BlocBuilder<PriceBloc, PriceState>(
              builder: (context, state) {
                return SwitchListTile(
                  contentPadding: const EdgeInsets.only(left: 8),
                  value: state.isPrice,
                  onChanged: (value) {
                    context.read<PriceBloc>().add(const ChangePrise());
                  },
                  title: Row(
                    children: [
                      AppIcons.dollarCircle
                          .svg(color: white, height: 16, width: 16),
                      const SizedBox(width: 8),
                      Text(
                        "Pulli",
                        style: AppTheme.bodySmall.copyWith(color: white50),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 4),

            /// Language Button
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                return Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: ExpansionTile(
                      backgroundColor: Colors.transparent,
                      collapsedBackgroundColor: Colors.transparent,
                      tilePadding: const EdgeInsets.symmetric(horizontal: 8),
                      title: Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: grey,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Organization",
                            style: AppTheme.bodySmall.copyWith(color: white50),
                          ),
                        ],
                      ),
                      trailing: Icon(
                        customTileExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        color: white.withOpacity(.5),
                      ),
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: white.withOpacity(0.2),
                              ),
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                ...List.generate(
                                  state.listSpecial.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: WLanguageButton(
                                      onTap: () async {
                                        if (state.listSpecial[index].id ==
                                            StorageRepository.getString(
                                                StorageKeys.SPID)) return;
                                        await StorageRepository.putString(
                                            StorageKeys.SPID,
                                            state.listSpecial[index].id);
                                        StorageRepository.putString(
                                                StorageKeys.COMPID,
                                                state.listSpecial[index].org
                                                    .slugName)!
                                            .then(
                                          (value) =>
                                              RestartWidget.restartApp(context),
                                        );
                                      },
                                      isActive: state.listSpecial[index].id ==
                                          StorageRepository.getString(
                                              StorageKeys.SPID),
                                      image: state.listSpecial[index].avatar,
                                      text: state
                                          .listSpecial[index].org.operationType,
                                      isLocalImage: false,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      onExpansionChanged: (bool expanded) {
                        setState(() {
                          customTileExpanded = expanded;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 4),

            /// Log Out Button
            WButton(
              onTap: () {
                context.read<AuthenticationBloc>().add(Logout());
              },
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              color: Colors.transparent,
              borderRadius: 8,
              child: Row(
                children: [
                  AppIcons.logout.svg(color: red),
                  const SizedBox(width: 8),
                  Text(
                    LocaleKeys.profileExit.tr(),
                    style: AppTheme.bodySmall.copyWith(
                      color: red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WLanguageButton extends StatelessWidget {
  final void Function() onTap;
  final String image;
  final String text;
  final bool isActive;
  final bool isLocalImage;

  const WLanguageButton({
    super.key,
    required this.onTap,
    required this.image,
    required this.text,
    required this.isActive,
    this.isLocalImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return WButton(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      color: isActive ? blue : Colors.transparent,
      borderRadius: 8,
      child: Row(
        children: [
          isLocalImage
              ? Image.asset(
                  image,
                  height: 16,
                  width: 16,
                )
              : image.isEmpty
                  ? const Icon(
                      Icons.person,
                      color: grey,
                      size: 16,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        image,
                        height: 16,
                        width: 16,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.person,
                          color: grey,
                          size: 16,
                        ),
                      ),
                    ),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppTheme.bodySmall.copyWith(
              color: white,
            ),
          ),
        ],
      ),
    );
  }
}
