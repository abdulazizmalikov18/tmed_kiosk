import 'package:tmed_kiosk/features/common/controllers/price_bloc/price_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/common/widgets/w_appbar.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/goods_view_model.dart';
import 'package:tmed_kiosk/features/goods/presentation/widgets/goods_shimmer_iteam.dart';
import 'package:tmed_kiosk/features/goods/presentation/widgets/w_goods_iteam.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/no_data_cart.dart';

class SelectionCatigoryView extends StatefulWidget {
  const SelectionCatigoryView({super.key, required this.id});
  final int id;

  @override
  State<SelectionCatigoryView> createState() => _SelectionCatigoryViewState();
}

class _SelectionCatigoryViewState extends State<SelectionCatigoryView> {
  final vm = GoodsViewModel();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyNavigatorBloc, MyNavigatorState>(
      builder: (context, stateN) {
        return Scaffold(
          appBar: WAppBar(
            onChanged: (value) {
              if (value.length % 3 == 0) {
                context
                    .read<GoodsBloc>()
                    .add(GetCategoryPro(widget.id, search: value));
              }
            },
            onTapRow: () {
              context.read<MyNavigatorBloc>().add(IsImage(!stateN.isImage));
            },
            rowIcon: stateN.isImage,
          ),
          body: BlocBuilder<GoodsBloc, GoodsState>(
            builder: (context, state) {
              if (state.status.isInProgress) {
                return GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: stateN.isImage
                        ? context.read<PriceBloc>().state.isPrice
                            ? 352
                            : 340
                        : context.read<PriceBloc>().state.isPrice
                            ? 164
                            : 140,
                    maxCrossAxisExtent: stateN.openCart ? 700 : 440,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) => const GoodsShimmerIteam(),
                );
              } else {
                if (state.catigoryPro.isNotEmpty) {
                  return BlocBuilder<CartBloc, CartState>(
                    builder: (context, stateCart) {
                      return GridView.builder(
                        padding: const EdgeInsets.all(20),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: stateN.isImage ? 352 : 164,
                          maxCrossAxisExtent: stateN.openCart ? 700 : 440,
                        ),
                        itemCount: state.catigoryPro.length,
                        itemBuilder: (context, index) => WGoodsItem(
                          blocCart: context.read<CartBloc>(),
                          isImage: stateN.isImage,
                          product: state.catigoryPro[index],
                          isLiked: stateCart.cartMap.containsKey(
                            state.catigoryPro[index].id,
                          ),
                          vm: vm,
                          bloc: context.read<GoodsBloc>(),
                          isPrice: context.read<PriceBloc>().state.isPrice,
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
        );
      },
    );
  }
}
