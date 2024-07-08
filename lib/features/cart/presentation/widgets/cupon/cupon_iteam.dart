import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/common/controllers/price_bloc/price_bloc.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_model.dart';
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: context.color.contColor,
                  border: Border.all(color: contColor.withOpacity(.1)),
                ),
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.adduser_coupon.tr(),
                      style: AppTheme.displayLarge
                          .copyWith(color: context.color.white),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<CuponModel>(
                              value: state.selectAccount.cupons.first,
                              icon: AppIcons.arrowDown.svg(color: greyText),
                              decoration: InputDecoration(
                                fillColor: context.color.contColor,
                                focusColor: context.color.contColor,
                                hoverColor: context.color.contColor,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: contColor.withOpacity(.1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: contColor.withOpacity(.1))),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: contColor.withOpacity(.1))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: contColor.withOpacity(.1))),
                              ),
                              focusColor: borderColor,
                              borderRadius: BorderRadius.circular(12),
                              dropdownColor: context.color.contColor,
                              items: state.selectAccount.cupons
                                  .map((CuponModel value) {
                                return DropdownMenuItem<CuponModel>(
                                  value: value,
                                  child: SizedBox(
                                    width: 200,
                                    child: Text(
                                      "${value.title} / ${value.productDiscount}%",
                                      style: TextStyle(
                                        color: context.color.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
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
