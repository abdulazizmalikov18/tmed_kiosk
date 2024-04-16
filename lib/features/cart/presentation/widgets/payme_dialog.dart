import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/images.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';

class PaymeDialog extends StatefulWidget {
  const PaymeDialog({
    super.key,
    required this.bloc,
    required this.vm,
    required this.vmA,
    required this.goodsBloc,
    required this.username, required this.context,
  });
  final CartBloc bloc;
  final CartViewModel vm;
  final AccountsViewModel vmA;
  final GoodsBloc goodsBloc;
  final String username;
  final BuildContext context;

  @override
  State<PaymeDialog> createState() => _PaymeDialogState();
}

class _PaymeDialogState extends State<PaymeDialog> {
  int index = -1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              if (index == 0) {
                index = -1;
              } else {
                index = 0;
              }
              setState(() {});
            },
            borderRadius: BorderRadius.circular(12),
            child: AnimatedContainer(
              duration: const Duration(microseconds: 300),
              width: double.infinity,
              decoration: BoxDecoration(
                color:
                    index == 0 ? blue.withOpacity(.1) : context.color.white.withOpacity(.1),
                borderRadius: BorderRadius.circular(12),
                border: index == 0 ? Border.all(color: blue) : null,
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset(AppImages.payme),
                  const SizedBox(height: 12),
                  Text(
                    "Payment via Pay Me",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: context.color.white),
                  ),
                  if (index == 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: QrImageView(
                        data: 'https://payme.uz',
                        version: QrVersions.auto,
                        size: 200.0,
                        eyeStyle: QrEyeStyle(
                          color: context.color.white,
                          eyeShape: QrEyeShape.square,
                        ),
                        dataModuleStyle: QrDataModuleStyle(
                          color: context.color.white,
                          dataModuleShape: QrDataModuleShape.square,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              if (index == 1) {
                index = -1;
              } else {
                index = 1;
              }
              setState(() {});
            },
            borderRadius: BorderRadius.circular(12),
            child: AnimatedContainer(
              duration: const Duration(microseconds: 300),
              width: double.infinity,
              decoration: BoxDecoration(
                color:
                    index == 1 ? blue.withOpacity(.1) : context.color.white.withOpacity(.1),
                borderRadius: BorderRadius.circular(12),
                border: index == 1 ? Border.all(color: blue) : null,
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset(AppImages.click),
                  const SizedBox(height: 12),
                  Text(
                    "Payment via Click",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400,color: context.color.white),
                  ),
                  if (index == 1)
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: QrImageView(
                        data: 'https://click.uz/',
                        version: QrVersions.auto,
                        size: 200.0,
                        eyeStyle: QrEyeStyle(
                          color: context.color.white,
                          eyeShape: QrEyeShape.square,
                        ),
                        dataModuleStyle: QrDataModuleStyle(
                          color: context.color.white,
                          dataModuleShape: QrDataModuleShape.square,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              if (index == 2) {
                widget.bloc.add(
                  CreatOrder(
                    username:
                        widget.username.isNotEmpty ? widget.username : null,
                    onSuccess: (data) {
                      Navigator.pop(context);
                      context.pop();
                      context.read<ShowPopUpBloc>().add(ShowPopUp(
                            message: MyFunctions.createPrice(context),
                            status: PopStatus.success,
                          ));
                      widget.goodsBloc.add(GetOrgProduct(isLoading: false));
                      widget.vmA.clearAccount(widget.context);
                      widget.vm.controllerComment.clear();
                    },
                    onError: (nima) {
                      context.read<ShowPopUpBloc>().add(
                          ShowPopUp(message: nima, status: PopStatus.error));
                    },
                  ),
                );
              } else {
                index = 2;
              }
              setState(() {});
            },
            borderRadius: BorderRadius.circular(12),
            child: AnimatedContainer(
              duration: const Duration(microseconds: 300),
              width: double.infinity,
              decoration: BoxDecoration(
                color:
                    index == 2 ? blue.withOpacity(.1) : context.color.white.withOpacity(.1),
                borderRadius: BorderRadius.circular(12),
                border: index == 2 ? Border.all(color: blue) : null,
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset(AppImages.cash),
                  const SizedBox(height: 12),
                  Text(
                    "Payment by cash",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400,color: context.color.white),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 24)
        ],
      ),
    );
  }
}
