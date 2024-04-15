import 'package:tmed_kiosk/features/common/controllers/price_bloc/price_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/cart_phone_view.dart';
import 'package:tmed_kiosk/features/common/navigation/presentation/navigator.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/goods_view_model.dart';
import 'package:tmed_kiosk/features/goods/presentation/widgets/goods_shimmer_iteam.dart';
import 'package:tmed_kiosk/features/goods/presentation/widgets/w_goods_iteam.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/no_data_cart.dart';

class SelectSpecialPhone extends StatefulWidget {
  const SelectSpecialPhone({super.key, required this.text});
  final String text;

  @override
  State<SelectSpecialPhone> createState() => _SelectSpecialPhoneState();
}

class _SelectSpecialPhoneState extends State<SelectSpecialPhone> {
  final vm = GoodsViewModel();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyNavigatorBloc, MyNavigatorState>(
      builder: (context, stateN) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: Text(widget.text),
          ),
          body: BlocBuilder<GoodsBloc, GoodsState>(
            builder: (context, state) {
              if (state.status.isInProgress) {
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: stateN.isImage ? 348 : 160,
                    maxCrossAxisExtent: stateN.openCart ? 700 : 440,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) => const GoodsShimmerIteam(),
                );
              } else {
                if (state.specialistPro.isEmpty) {
                  return const Center(
                    child: NoDataCart(
                      image: AppIcons.noData,
                      title: 'Nothing have',
                      isButton: true,
                    ),
                  );
                } else {
                  return BlocBuilder<CartBloc, CartState>(
                    builder: (context, stateCart) {
                      return ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        padding: const EdgeInsets.all(16),
                        itemCount: state.specialistPro.length,
                        itemBuilder: (context, index) => InkWell(
                          onLongPress: () {
                            context
                                .read<MyNavigatorBloc>()
                                .add(IsImage(!stateN.isImage));
                          },
                          child: WGoodsItem(
                            blocCart: context.read<CartBloc>(),
                            bloc: context.read<GoodsBloc>(),
                            isPhone: true,
                            isImage: stateN.isImage,
                            product: state.specialistPro[index],
                            isLiked: stateCart.cartMap.containsKey(
                              state.specialistPro[index].id,
                            ),
                            vm: vm,
                            isPrice: context.read<PriceBloc>().state.isPrice,
                          ),
                        ),
                      );
                    },
                  );
                }
              }
            },
          ),
          bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return state.cartMap.isNotEmpty
                  ? WButton(
                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      onTap: () {
                        Navigator.of(context).push(
                            fade(page: CartPhoneView(vm: AccountsViewModel())));
                      },
                      text: "Оформить/ ${state.cartMap.length} позиции выбраны",
                    )
                  : const SizedBox();
            },
          ),
        );
      },
    );
  }
}
