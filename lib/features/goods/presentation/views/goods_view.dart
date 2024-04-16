import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/core/utils/size_config.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/common/controllers/price_bloc/price_bloc.dart';
import 'package:tmed_kiosk/features/common/navigation/routs_contact.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/presentation/views/goods_phone_view.dart';

// import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/category/presentation/controllers/bloc/category_bloc.dart';
import 'package:tmed_kiosk/features/common/pagination/presentation/paginator.dart';
import 'package:tmed_kiosk/features/common/widgets/nwe_appbar.dart';
import 'package:tmed_kiosk/features/common/widgets/w_search_button.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/goods_view_model.dart';
import 'package:tmed_kiosk/features/goods/presentation/widgets/bottom_category_list.dart';
import 'package:tmed_kiosk/features/goods/presentation/widgets/goods_shimmer_iteam.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:tmed_kiosk/features/goods/presentation/widgets/w_goods_iteam.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/no_data_cart.dart';
// import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';

class GoodsView extends StatefulWidget {
  const GoodsView({super.key});

  @override
  State<GoodsView> createState() => _GoodsViewState();
}

class _GoodsViewState extends State<GoodsView> {
  final vm = GoodsViewModel();
  int index = 0;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.sizeOf(context).width < 800) {
      return GoodsPhoneView(vm: AccountsViewModel(), vmC: CartViewModel());
    }
    return BlocBuilder<MyNavigatorBloc, MyNavigatorState>(
      builder: (context, stateN) {
        return Scaffold(
          backgroundColor: context.color.backGroundColor,
          appBar: NewAppBar(
            title: "product_category".tr(),
            action: [
              InkWell(
                onTap: () {
                  context.read<MyNavigatorBloc>().add(IsImage(!stateN.isImage));
                },
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: AppIcons.size.svg(
                      color: stateN.isImage
                          ? null
                          : context.color.white.withOpacity(.5)),
                ),
              ),
            ],
            child: Row(
              children: [
                const Expanded(child: BottomCategoryList()),
                const SizedBox(width: 16),
                WSearchButton(
                  controller: searchController,
                  onEditingComplete: () {
                    context
                        .read<GoodsBloc>()
                        .add(GetOrgProduct(search: searchController.text));
                  },
                  onChanged: (String value) {},
                )
              ],
            ),
          ),
          body: BlocBuilder<PriceBloc, PriceState>(
            builder: (context, statePrice) {
              return BlocBuilder<GoodsBloc, GoodsState>(
                builder: (context, state) {
                  if (state.statusProduct.isInProgress) {
                    return GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        mainAxisExtent: stateN.isImage
                            ? statePrice.isPrice
                                ? SizeConfig.h(328)
                                : SizeConfig.h(302)
                            : statePrice.isPrice
                                ? SizeConfig.h(168)
                                : SizeConfig.h(118),
                        maxCrossAxisExtent: stateN.openCart
                            ? statePrice.isPrice
                                ? SizeConfig.h(700)
                                : SizeConfig.h(440)
                            : SizeConfig.h(440),
                      ),
                      itemCount: 40,
                      itemBuilder: (context, index) =>
                          const GoodsShimmerIteam(),
                    );
                  } else {
                    if (state.orgProduct.isNotEmpty) {
                      return Paginator(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          crossAxisSpacing: SizeConfig.v(16),
                          mainAxisSpacing: SizeConfig.h(16),
                          mainAxisExtent: stateN.isImage
                              ? statePrice.isPrice
                                  ? SizeConfig.h(328)
                                  : SizeConfig.h(302)
                              : statePrice.isPrice
                                  ? SizeConfig.h(168)
                                  : SizeConfig.h(118),
                          maxCrossAxisExtent: stateN.openCart
                              ? statePrice.isPrice
                                  ? SizeConfig.h(700)
                                  : SizeConfig.h(440)
                              : SizeConfig.h(440),
                        ),
                        itemCount:
                            context.read<CategoryBloc>().state.selIndex == 0
                                ? state.orgProduct.length
                                : state.catigoryPro.length,
                        itemBuilder: (context, index) => WGoodsItem(
                          isImage: stateN.isImage,
                          product:
                              context.watch<CategoryBloc>().state.selIndex == 0
                                  ? state.orgProduct[index]
                                  : state.catigoryPro[index],
                          isLiked: context
                              .watch<CartBloc>()
                              .state
                              .cartMap
                              .containsKey(
                                context.watch<CategoryBloc>().state.selIndex ==
                                        0
                                    ? state.orgProduct[index].id
                                    : state.catigoryPro[index].id,
                              ),
                          vm: vm,
                          isPrice: statePrice.isPrice,
                          bloc: context.read<GoodsBloc>(),
                          blocCart: context.read<CartBloc>(),
                        ),
                        errorWidget: const SizedBox(),
                        fetchMoreFunction: () {
                          if (context.watch<CategoryBloc>().state.selIndex ==
                              0) {
                            context.read<GoodsBloc>().add(GetMoreOrgProduct());
                          } else {
                            context.read<GoodsBloc>().add(
                                GetMoreProductCategory(context
                                    .watch<CategoryBloc>()
                                    .state
                                    .category[context
                                        .watch<CategoryBloc>()
                                        .state
                                        .selIndex]
                                    .id!));
                          }
                        },
                        loadingWidget: const GoodsShimmerIteam(),
                        hasMoreToFetch:
                            context.watch<CategoryBloc>().state.selIndex == 0
                                ? (state.count > state.orgProduct.length)
                                : (state.countCategory >
                                    state.catigoryPro.length),
                        paginatorStatus: state.statusProduct,
                      );
                    } else {
                      return Center(
                        child: NoDataCart(
                          image: AppIcons.noData,
                          title: 'nothing_have'.tr(),
                          isButton: true,
                        ),
                      );
                    }
                  }
                },
              );
            },
          ),
          bottomNavigationBar:
              BlocSelector<CartBloc, CartState, Map<int, OrgProductEntity>>(
            selector: (state) => state.cartMap,
            builder: (context, cartMap) {
              if (cartMap.isNotEmpty) {
                return WButton(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  onTap: () {
                    context.push(RoutsContact.cart);
                  },
                  text: "Xizmatlar soni / ${cartMap.length} ta",
                );
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}
