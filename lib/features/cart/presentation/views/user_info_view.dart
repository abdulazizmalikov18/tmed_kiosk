import 'package:easy_localization/easy_localization.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/add_user_iteam_phone.dart';
import 'package:tmed_kiosk/features/common/navigation/routs_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/add_user_iteam.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/widgets/w_tab_bar.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/no_data_cart.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class UserInfoView extends StatefulWidget {
  const UserInfoView({super.key, required this.vm, this.isPhone = false});
  final AccountsViewModel vm;
  final bool isPhone;

  @override
  State<UserInfoView> createState() => _UserInfoViewState();
}

class _UserInfoViewState extends State<UserInfoView> {
  @override
  void initState() {
    context.read<AccountsBloc>().add(GetHistory(
      onError: (valu) {
        context
            .read<ShowPopUpBloc>()
            .add(ShowPopUp(message: valu, status: PopStatus.error));
      },
    ));
    context.read<AccountsBloc>().add(GetReccommendation());
    super.initState();
    widget.vm.selectAccount(
        context.read<AccountsBloc>().state.selectAccount.selectAccount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DefaultTabController(
        length: 3,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          color: context.color.contColor,
          child: Column(
            children: [
              SizedBox(
                height: 48,
                width: double.infinity,
                child: WTabBar(
                  tabs: [
                    Text(LocaleKeys.user_info.tr()),
                    Text(LocaleKeys.user_history.tr()),
                    Text(LocaleKeys.user_retsept.tr()),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: TabBarView(
                  children: [
                    if (widget.isPhone)
                      AddUsetIteamPhone(
                        onTap: () {},
                        vm: widget.vm,
                      )
                    else
                      AddUsetIteam(vm: widget.vm),
                    BlocBuilder<AccountsBloc, AccountsState>(
                      builder: (context, state) {
                        if (state.status.isInProgress) {
                          return Column(
                            children: [
                              Container(
                                height: 48,
                                margin: const EdgeInsets.all(16),
                                child: Shimmer.fromColors(
                                  baseColor: blue.withOpacity(0.13),
                                  highlightColor: blue.withOpacity(0.01),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: blue,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: 8,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  itemBuilder: (context, index) => Container(
                                    height: 94,
                                    margin: const EdgeInsets.only(bottom: 16),
                                    child: Shimmer.fromColors(
                                      baseColor: blue.withOpacity(0.13),
                                      highlightColor: blue.withOpacity(0.01),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (state.historys.isNotEmpty) {
                          return ListView.separated(
                            itemCount: state.historys.length,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
                            itemBuilder: (context, index) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: context.color.whiteBlack,
                                border: Border.all(
                                    color:
                                        context.color.white.withOpacity(0.3)),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      state.historys[index].name,
                                      style: AppTheme.bodyMedium
                                          .copyWith(color: context.color.white),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    state.historys[index].currentWorkState
                                        .status.name,
                                    style: AppTheme.bodyLarge.copyWith(
                                        color: green,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Divider(
                                      color:
                                          context.color.white.withOpacity(.1),
                                      height: 24),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 20,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "${MyFunctions.getThousandsSeparatedPrice(
                                              state.historys[index].fullCost
                                                  .toString(),
                                            )} UZS",
                                            style: AppTheme.bodyLarge.copyWith(
                                                color: context.color.white),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: RichText(
                                            text: TextSpan(
                                              text: "${LocaleKeys.soni.tr()}: ",
                                              style: AppTheme.bodyLarge
                                                  .copyWith(
                                                      color:
                                                          context.color.white),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "x${state.historys[index].order.status}",
                                                  style: AppTheme.bodyLarge
                                                      .copyWith(
                                                          color: context
                                                              .color.white
                                                              .withOpacity(.5)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            state.historys[index].order
                                                    .createDate.isNotEmpty
                                                ? MyFunctions.getformDate(state
                                                    .historys[index]
                                                    .order
                                                    .createDate)
                                                : '--/------',
                                            style: AppTheme.labelSmall
                                                .copyWith(fontSize: 16),
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Center(
                            child: NoDataCart(
                              image: AppIcons.noData,
                              title: LocaleKeys.nothing_have.tr(),
                              isButton: false,
                            ),
                          );
                        }
                      },
                    ),
                    BlocBuilder<AccountsBloc, AccountsState>(
                      builder: (context, state) {
                        if (state.statusd.isInProgress) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: context.color.whiteBlack,
                              border: Border.all(
                                  color: context.color.white.withOpacity(0.3)),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocaleKeys.retsept.tr(),
                                  style: AppTheme.displaySmall.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: context.color.white),
                                ),
                                Divider(
                                    color: white.withOpacity(.1), height: 24),
                                Expanded(
                                  child: ListView.separated(
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        context
                                            .read<CartBloc>()
                                            .add(CartAddRecommendation(
                                              products: state
                                                  .recommendations[index]
                                                  .products,
                                              onSuccess: () {
                                                context.go(RoutsContact.goods);
                                              },
                                              onError: (error) {
                                                context
                                                    .read<ShowPopUpBloc>()
                                                    .add(ShowPopUp(
                                                        message: LocaleKeys
                                                            .no_information_found
                                                            .tr(),
                                                        status:
                                                            PopStatus.warning));
                                              },
                                            ));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: context.color.borderColor,
                                          border: Border.all(
                                              color: context.color.white
                                                  .withOpacity(0.3)),
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${state.recommendations[index].specialist.name} ${state.recommendations[index].specialist.lastname}",
                                                    style: AppTheme.displayLarge
                                                        .copyWith(
                                                            color: context
                                                                .color.white),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    state.recommendations[index]
                                                        .specialist.job,
                                                    style: AppTheme.labelSmall
                                                        .copyWith(
                                                            color: context
                                                                .color.white
                                                                .withOpacity(
                                                                    .5)),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${state.recommendations[index].products.length} ${LocaleKeys.retsept.tr()}",
                                                    style: AppTheme.displayLarge
                                                        .copyWith(
                                                            color: context
                                                                .color.white),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    MyFunctions.parseDate(state
                                                        .recommendations[index]
                                                        .createDate),
                                                    style: AppTheme.labelSmall
                                                        .copyWith(
                                                            color: context
                                                                .color.white
                                                                .withOpacity(
                                                                    .5)),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 12),
                                    itemCount: state.recommendations.length,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
