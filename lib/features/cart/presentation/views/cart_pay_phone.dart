import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/constants/images.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/process_status_entity.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/pay_bottom.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/price_info_phone.dart';
import 'package:tmed_kiosk/features/common/widgets/w_scale_animation.dart';
import 'package:tmed_kiosk/features/main/domain/entity/price_entity.dart';

import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class CartPayPhone extends StatefulWidget {
  const CartPayPhone({
    super.key,
    this.isOrder = false,
    this.id = '',
    required this.vm,
  });
  final bool isOrder;
  final String id;
  final CartViewModel vm;

  @override
  State<CartPayPhone> createState() => _CartPayPhoneState();
}

class _CartPayPhoneState extends State<CartPayPhone> {
  final ScrollController _controller = ScrollController();
  List<MyPriceEntity> list = [
    MyPriceEntity(
      controller: TextEditingController(),
      name: LocaleKeys.payOrderName.tr(),
      method: 1,
    ),
    MyPriceEntity(
      controller: TextEditingController(),
      name: LocaleKeys.payOrderCash.tr(),
      method: 1,
    ),
    MyPriceEntity(
      controller: TextEditingController(),
      name: LocaleKeys.payOrderHumo.tr(),
      image: AppImages.humo,
      method: 7,
    ),
    MyPriceEntity(
      controller: TextEditingController(),
      name: LocaleKeys.payOrderUzcard.tr(),
      image: AppImages.uzcard,
      method: 8,
    ),
  ];
  List<MyPriceEntity> list2 = [
    MyPriceEntity(
      controller: TextEditingController(),
      name: LocaleKeys.payOrderTransfer.tr(),
      method: 6,
    ),
    MyPriceEntity(
      controller: TextEditingController(),
      name: LocaleKeys.payOrderCashback.tr(),
      method: 5,
    ),
    MyPriceEntity(
      controller: TextEditingController(),
      name: LocaleKeys.payOrderAnor.tr(),
      image: AppImages.anorbank,
      method: 11,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (_) async {
        widget.vm.closePay();
      },
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return KeyboardDismisser(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: const Text("Pay"),
                toolbarHeight: 56,
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: list.length,
                              padding: const EdgeInsets.only(bottom: 16),
                              controller: _controller,
                              itemBuilder: (context, index) => Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                child: TextField(
                                  keyboardType: index != 0
                                      ? Platform.isIOS
                                          ? const TextInputType
                                              .numberWithOptions(
                                              signed: true,
                                              decimal: true,
                                            )
                                          : TextInputType.number
                                      : null,
                                  onChanged: (p0) {
                                    widget.vm.checkPrice(
                                        list, state.allPrice, index);
                                    setState(() {});
                                  },
                                  onTap: () {
                                    widget.vm.textPrice(list, state.allPrice,
                                        index, state.avans);
                                    setState(() {});
                                  },
                                  controller: list[index].controller,
                                  inputFormatters: index != 0
                                      ? [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]')),
                                        ]
                                      : [],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            const BorderSide(color: inputBlue)),
                                    prefix: list[index].image != null
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                right: 12),
                                            child: Image.asset(
                                              list[index].image!,
                                              height: 20,
                                              width: 40,
                                            ),
                                          )
                                        : null,
                                    labelText: list[index].name,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (list2.isNotEmpty)
                            WScaleAnimation(
                              onTap: () {
                                setState(() {
                                  list.add(list2[0]);
                                  list2.removeAt(0);
                                  _controller.animateTo(
                                    (list.length - 1) * 40,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn,
                                  );
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: const Color(0xFFD5E5FB))),
                                height: 56,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Other method",
                                          style: AppTheme.labelLarge,
                                        ),
                                        Text(
                                          "Add other method for pay",
                                          style: AppTheme.bodyLarge.copyWith(
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    SvgPicture.asset(
                                      AppIcons.addCircle,
                                      colorFilter: const ColorFilter.mode(
                                          dark, BlendMode.srcIn),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: contColor,
                        border: Border.all(color: inputBlue),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButtonFormField<ProcessStatusEntity>(
                        value: state.selStatus,
                        icon: SvgPicture.asset(AppIcons.arrowDown),
                        decoration: const InputDecoration(
                          fillColor: contColor,
                          focusColor: contColor,
                          hoverColor: contColor,
                          border: InputBorder.none,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        dropdownColor: contColor,
                        items: state.processStatus
                            .map((ProcessStatusEntity value) {
                          return DropdownMenuItem<ProcessStatusEntity>(
                            value: value,
                            child: Text(
                              value.name,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          context
                              .read<CartBloc>()
                              .add(SelStatus(selStatus: newValue!));
                        },
                      ),
                    ),
                    PriceInfoPhone(
                      allPrice: state.allPrice,
                      discount: state.discount,
                      isOrder: widget.isOrder,
                      avans: state.avans,
                      moneyEntered: widget.vm.moneyEntered,
                      vat: state
                              .cartMap[(state.cartMap.keys).toList()[0]]?.vat ??
                          0,
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: PayButton(
                list: list,
                isOrder: widget.isOrder,
                id: widget.id,
                isAllPrice:
                    state.allPrice <= widget.vm.moneyEntered + state.avans,
              ),
            ),
          );
        },
      ),
    );
  }
}
