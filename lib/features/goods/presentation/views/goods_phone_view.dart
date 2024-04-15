import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/common/controllers/price_bloc/price_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/cart_phone_view.dart';
import 'package:tmed_kiosk/features/category/presentation/controllers/bloc/category_bloc.dart';
import 'package:tmed_kiosk/features/common/navigation/presentation/navigator.dart';
import 'package:tmed_kiosk/features/common/pagination/presentation/paginator_list.dart';
import 'package:tmed_kiosk/features/common/widgets/w_appbar_ph.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/goods_view_model.dart';
import 'package:tmed_kiosk/features/goods/presentation/widgets/bottom_category_list.dart';
import 'package:tmed_kiosk/features/goods/presentation/widgets/goods_shimmer_iteam.dart';
import 'package:tmed_kiosk/features/goods/presentation/widgets/w_goods_iteam.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/no_data_cart.dart';

class GoodsPhoneView extends StatefulWidget {
  const GoodsPhoneView({super.key, required this.vm, required this.vmC});
  final AccountsViewModel vm;
  final CartViewModel vmC;

  @override
  State<GoodsPhoneView> createState() => _GoodsPhoneViewState();
}

class _GoodsPhoneViewState extends State<GoodsPhoneView> {
  final vm = GoodsViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyNavigatorBloc, MyNavigatorState>(
      builder: (context, stateN) {
        return Scaffold(
          extendBody: true,
          appBar: WAppBarPhone(
            isQrcode: true,
            vmC: widget.vmC,
            onChanged: (value) {
              context.read<GoodsBloc>().add(GetOrgProduct(search: value));
            },
            child: const BottomCategoryList(isPhone: true),
          ),
          body: BlocBuilder<GoodsBloc, GoodsState>(
            builder: (context, state) {
              if (state.statusProduct.isInProgress) {
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: stateN.isImage ? 348 : 160,
                    maxCrossAxisExtent: stateN.openCart ? 700 : 440,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) => const GoodsShimmerIteam(),
                );
              } else {
                if (state.orgProduct.isNotEmpty) {
                  return BlocBuilder<PriceBloc, PriceState>(
                    builder: (context, statePrice) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<GoodsBloc>().add(GetOrgProduct());
                        },
                        child: PaginatorList(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 64),
                          itemCount:
                              context.read<CategoryBloc>().state.selIndex == 0
                                  ? state.orgProduct.length
                                  : state.catigoryPro.length,
                          itemBuilder: (context, index) => InkWell(
                            onLongPress: () {
                              context
                                  .read<MyNavigatorBloc>()
                                  .add(IsImage(!stateN.isImage));
                            },
                            child: WGoodsItem(
                              bloc: context.read<GoodsBloc>(),
                              blocCart: context.read<CartBloc>(),
                              isImage: stateN.isImage,
                              product: context
                                          .watch<CategoryBloc>()
                                          .state
                                          .selIndex ==
                                      0
                                  ? state.orgProduct[index]
                                  : state.catigoryPro[index],
                              isLiked: context
                                  .watch<CartBloc>()
                                  .state
                                  .cartMap
                                  .containsKey(
                                    context
                                                .watch<CategoryBloc>()
                                                .state
                                                .selIndex ==
                                            0
                                        ? state.orgProduct[index].id
                                        : state.catigoryPro[index].id,
                                  ),
                              isPhone: true,
                              vm: vm,
                              isPrice: statePrice.isPrice,
                            ),
                          ),
                          errorWidget: const SizedBox(),
                          fetchMoreFunction: () {
                            if (context.watch<CategoryBloc>().state.selIndex ==
                                0) {
                              context
                                  .read<GoodsBloc>()
                                  .add(GetMoreOrgProduct());
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
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                          loadingWidget: const GoodsShimmerIteam(),
                          hasMoreToFetch:
                              context.watch<CategoryBloc>().state.selIndex == 0
                                  ? (state.count > state.orgProduct.length)
                                  : state.countCategory >
                                      state.catigoryPro.length,
                          paginatorStatus: state.statusProduct,
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: NoDataCart(
                      image: AppIcons.noData,
                      title: 'Nothing have',
                      isButton: true,
                    ),
                  );
                }
              }
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
                    Navigator.of(context)
                        .push(fade(page: CartPhoneView(vm: widget.vm)));
                  },
                  text: "Vazifa berish / ${cartMap.length} ta",
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
