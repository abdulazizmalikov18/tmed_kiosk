import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/common/controllers/auth/authentication_bloc.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/common/widgets/w_scale_animation.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/selection_currenci.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/selection_lenguage.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/w_list_selection.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class ShowProfile extends StatefulWidget {
  const ShowProfile({super.key});

  @override
  State<ShowProfile> createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  final PageController _pageController = PageController();
  String lenguage = StorageRepository.getString('language');

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool isOnli = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return AlertDialog(
          insetPadding: const EdgeInsets.only(
            left: 80,
            bottom: 28,
          ),
          backgroundColor: contColor,
          alignment: AlignmentDirectional.bottomStart,
          contentPadding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          content: Container(
            width: 368,
            height: 436,
            padding: const EdgeInsets.all(24),
            child: PageView(
              controller: _pageController,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
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
                        const SizedBox(width: 12),
                        WScaleAnimation(
                          onTap: () {},
                          child: AppIcons.arrowSwapHorizontal.svg(color: white),
                        ),
                      ],
                    ),
                    const Divider(),
                    SwitchListTile(
                      contentPadding: const EdgeInsets.all(0),
                      value: isOnli,
                      onChanged: (value) {
                        setState(() {
                          isOnli = value;
                        });
                      },
                      title: Text(
                        LocaleKeys.profile_start_work.tr(),
                        style: AppTheme.displayLarge,
                      ),
                    ),
                    WListSelection(
                      image: AppIcons.languageCircle,
                      onTap: () {
                        _pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      title: LocaleKeys.profile_language.tr(),
                      isLenguage: true,
                    ),
                    const SizedBox(height: 24),
                    WListSelection(
                      image: AppIcons.dollarCircle,
                      onTap: () {
                        _pageController.animateToPage(
                          2,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      title: LocaleKeys.profile_currency.tr(),
                      isText: true,
                    ),
                    const SizedBox(height: 24),
                    WListSelection(
                      image: AppIcons.infoCircle,
                      onTap: () {},
                      title: LocaleKeys.profile_exit.tr(),
                    ),
                    const SizedBox(height: 24),
                    WButton(
                      onTap: () {
                        Navigator.pop(context);
                        context.read<AuthenticationBloc>().add(Logout());
                        context.read<CartBloc>().add(CartRemove());
                      },
                      color: red,
                      text: LocaleKeys.profile_exit.tr(),
                    )
                  ],
                ),
                SelectionLenguage(pageController: _pageController),
                SelectionCurrency(pageController: _pageController),
              ],
            ),
          ),
        );
      },
    );
  }
}
