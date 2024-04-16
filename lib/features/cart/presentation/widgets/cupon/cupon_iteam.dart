import 'package:tmed_kiosk/features/common/controllers/price_bloc/price_bloc.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/cupon_entity.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';

class CuponIteam extends StatefulWidget {
  const CuponIteam({
    super.key,
    required this.vm,
  });
  final CartViewModel vm;

  @override
  State<CuponIteam> createState() => _CuponIteamState();
}

class _CuponIteamState extends State<CuponIteam> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, stateCart) {
        return BlocBuilder<AccountsBloc, AccountsState>(
          builder: (context, state) {
            if (state.selectAccount.cupons.isNotEmpty ||
                stateCart.cupon.title.isNotEmpty &&
                    context.watch<PriceBloc>().state.isPrice) {
              return Container(
                decoration: wdecoration2,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.adduser_coupon.tr(),
                      style: AppTheme.displayLarge,
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<CuponEntity>(
                              value: state.selectAccount.cupons.first,
                              icon: AppIcons.arrowDown.svg(color: white50),
                              decoration: InputDecoration(
                                fillColor: borderColor,
                                focusColor: borderColor,
                                hoverColor: borderColor,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: greyText),
                                ),
                              ),
                              focusColor: borderColor,
                              borderRadius: BorderRadius.circular(12),
                              dropdownColor: borderColor,
                              items: state.selectAccount.cupons
                                  .map((CuponEntity value) {
                                return DropdownMenuItem<CuponEntity>(
                                  value: value,
                                  child: Text(
                                      "${value.title} / ${value.productDiscount}%"),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                if (newValue != null && widget.vm.isCupon) {
                                  context.read<AccountsBloc>().add(
                                        SelectionCupon(
                                          id: state.selectAccount.cupons
                                              .indexWhere((element) =>
                                                  element.id == newValue.id),
                                          onCupon: (cupon) {
                                            widget.vm.cuponSelction(
                                              context: context,
                                              cupon: cupon,
                                              counts: stateCart.counts,
                                              cartMap: stateCart.cartMap,
                                            );
                                            context
                                                .read<CartBloc>()
                                                .add(CuponSel(cupon: cupon));
                                          },
                                          isDisebled: widget.vm.isCupon,
                                        ),
                                      );
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            height: 40,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: CupertinoSwitch(
                                activeColor: blue,
                                value: widget.vm.isCupon,
                                onChanged: (value) {
                                  widget.vm.isCupon = value;
                                  context.read<AccountsBloc>().add(
                                        SelectionCupon(
                                          id: 0,
                                          onCupon: (cupon) {
                                            widget.vm.cuponSelction(
                                              context: context,
                                              cupon: cupon,
                                              counts: stateCart.counts,
                                              cartMap: stateCart.cartMap,
                                            );
                                            context
                                                .read<CartBloc>()
                                                .add(CuponSel(cupon: cupon));
                                          },
                                          isDisebled: widget.vm.isCupon,
                                        ),
                                      );
                                  setState(() {});
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        );
      },
    );
  }
}
