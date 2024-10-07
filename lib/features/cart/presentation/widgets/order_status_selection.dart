import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/process_status_entity.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/common/widgets/bottom_sheet_widget.dart';
import 'package:tmed_kiosk/features/common/widgets/dialog_title.dart';
import 'package:tmed_kiosk/features/common/widgets/modal_bottom_sheets.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class OrderStatusSelection extends StatefulWidget {
  const OrderStatusSelection({super.key});

  @override
  State<OrderStatusSelection> createState() => _OrderStatusSelectionState();
}

class _OrderStatusSelectionState extends State<OrderStatusSelection> {
  @override
  Widget build(BuildContext context) {
    final size = MyFunctions.paddingRespons(MediaQuery.sizeOf(context).height);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.color.contColor,
        // boxShadow: wboxShadow,
        border: Border.all(
          color: context.color.white.withOpacity(0.1),
        ),
      ),
      padding: EdgeInsets.all(size),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "status_order_status_action".tr(),
            style: AppTheme.bodyLarge.copyWith(color: context.color.white),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      Log.w(state.selStatus);
                      Log.w(state.processStatus);
                      // return GestureDetector(
                      //   onTap: () {
                      //     chengeStatus(parentContext: context);
                      //   },
                      //   child: DecoratedBox(
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(8),
                      //       border: Border.all(
                      //         color: context.color.white.withOpacity(0.1),
                      //       ),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 12),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(
                      //             state.selStatus.name,
                      //             style: AppTheme.labelLarge.copyWith(
                      //               color: context.color.white.withOpacity(.5),
                      //             ),
                      //           ),
                      //           AppIcons.arrowDown.svg(color: greyText),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // );
                      return DropdownButtonFormField<ProcessStatusEntity>(
                        value: state.selStatus,
                        // onTap: () {
                        //   chengeStatus(parentContext: context);
                        // },
                        icon: AppIcons.arrowDown.svg(color: greyText),
                        decoration: InputDecoration(
                          fillColor: context.color.borderColor,
                          focusColor: context.color.borderColor,
                          hoverColor: context.color.borderColor,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: context.color.white.withOpacity(0.1),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: context.color.white.withOpacity(0.1),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: context.color.white.withOpacity(0.1),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: contColor.withOpacity(.1)),
                          ),
                        ),
                        borderRadius: BorderRadius.circular(12),
                        dropdownColor: context.color.contColor,
                        items: state.processStatus.map((ProcessStatusEntity value) {
                          return DropdownMenuItem<ProcessStatusEntity>(
                            value: value,
                            child: SizedBox(
                              width: 220,
                              child: Text(
                                value.name,
                                style: AppTheme.labelLarge.copyWith(
                                  color: context.color.white.withOpacity(.5),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          Log.w(newValue);
                          context.read<CartBloc>().add(SelStatus(selStatus: newValue!));
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              WButton(
                onTap: () {
                  final bloc = context.read<CartBloc>();
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      insetPadding: Platform.isAndroid || Platform.isIOS ? const EdgeInsets.symmetric(horizontal: 12) : null,
                      title: const DialogTitle(title: "Status"),
                      actions: [
                        WButton(
                          onTap: () {
                            Navigator.pop(_);
                          },
                          margin: const EdgeInsets.only(top: 12),
                          text: LocaleKeys.adduser_save.tr(),
                        )
                      ],
                      content: SizedBox(
                        height: 600,
                        width: 400,
                        child: BlocBuilder<CartBloc, CartState>(
                          bloc: bloc,
                          builder: (context, state) {
                            return ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              itemBuilder: (_, index) => CheckboxListTile(
                                key: Key('$index'),
                                controlAffinity: ListTileControlAffinity.leading,
                                title: Text(
                                  state.processStatusAll[index].name,
                                  style: AppTheme.bodyLarge.copyWith(
                                    color: context.color.white,
                                  ),
                                ),
                                activeColor: context.color.blue,
                                checkColor: white,
                                checkboxShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                value: state.statusID.contains(state.processStatusAll[index].id),
                                onChanged: (bool? value) {
                                  Log.w(value);
                                  bloc.add(StatusActive(id: state.processStatusAll[index].id));
                                },
                              ),
                              itemCount: state.processStatusAll.length,
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                height: 40,
                color: context.color.contColor,
                border: Border.all(color: context.color.white.withOpacity(0.1)),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: const Icon(Icons.edit, color: greyText,),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Future<dynamic> chengeStatus({required BuildContext parentContext}) {
    final ValueNotifier<int?> activeCtr = ValueNotifier<int?>(null);
    return ModalBottomSheets.showSimpleBottomSheet(
      isScrollControlled: true,
      parentContext,
      constrains: BoxConstraints(
        maxHeight: MediaQuery.of(parentContext).size.height - 200,
      ),
      child: BlocBuilder<CartBloc, CartState>(
        bloc: parentContext.read<CartBloc>(),
        builder: (context, state) {
          return ValueListenableBuilder(
            valueListenable: activeCtr,
            builder: (context, activeIndex, child) {
              return BottomSheetWidget(
                horizontal: 16,
                title: "changing_the_task".tr(),
                backgroundColor: context.color.contColor,
                children: [
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.processStatus.length,
                      separatorBuilder: (context, indexS) => const SizedBox(height: 12),
                      itemBuilder: (context, indexS) => InkWell(
                        onTap: () {
                          activeCtr.value = indexS;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: activeCtr.value == indexS ? blue : context.color.blue.withOpacity(.2),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: Text(
                            state.processStatus[indexS].name,
                            style: AppTheme.labelSmall.copyWith(color: context.color.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ValueListenableBuilder(
                    valueListenable: activeCtr,
                    builder: (BuildContext context, int? value, Widget? child) {
                      return WButton(
                        isDisabled: value == null,
                        onTap: () {
                          final bloc = parentContext.read<CartBloc>();
                          bloc.add(SelStatus(selStatus: bloc.state.processStatus[activeCtr.value!]));
                          Navigator.pop(context);
                        },
                        color:activeCtr.value != null ? blue :  context.color.blue.withOpacity(.2),
                        text: "choose".tr(),
                        textStyle: TextStyle(color: context.color.white),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
