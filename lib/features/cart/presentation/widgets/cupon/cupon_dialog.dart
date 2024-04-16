import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/common/widgets/w_textfield.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/cupon_entity.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/widgets/dialog_title.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';

class CuponDialog extends StatefulWidget {
  const CuponDialog({
    super.key,
    required this.vm,
    required this.cupons,
    required this.username,
  });
  final AccountsViewModel vm;
  final List<CuponEntity> cupons;
  final String username;

  @override
  State<CuponDialog> createState() => _CuponDialogState();
}

class _CuponDialogState extends State<CuponDialog> {
  List<CuponEntity> cupons = [];
  List<CuponEntity> remove = [];
  List<CuponEntity> add = [];
  bool isChanged = false;
  @override
  void initState() {
    context.read<AccountsBloc>().add(GetCupon());
    cupons = List.from(widget.cupons);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        return SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const DialogTitle(title: "Select coupon"),
              const SizedBox(height: 8),
              WTextField(
                onChanged: (value) {
                  context.read<AccountsBloc>().add(GetCupon(search: value));
                },
                hintText: LocaleKeys.offerpage_search.tr(),
                suffix: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: AppIcons.search.svg(),
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 400,
                  child: Builder(
                    builder: (context) {
                      if (state.status.isInProgress) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                          itemCount: state.cupons.length,
                          itemBuilder: (context, index) {
                            final isSelec = widget.cupons
                                .where((element) =>
                                    element.id == state.cupons[index].id)
                                .isNotEmpty;
                            final isSelection = cupons
                                .where((element) =>
                                    element.id == state.cupons[index].id)
                                .isNotEmpty;
                            return InkWell(
                              onTap: () {
                                if (isSelection) {
                                  remove.add(state.cupons[index]);
                                  add.remove(state.cupons[index]);
                                  cupons.remove(state.cupons[index]);
                                } else {
                                  if (!isSelec) {
                                    add.add(state.cupons[index]);
                                  }
                                  remove.remove(state.cupons[index]);
                                  cupons.add(state.cupons[index]);
                                }
                                isChanged = true;
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isSelection ? blue : contGrey,
                                  border: const Border(
                                      bottom: BorderSide(color: greyText)),
                                ),
                                child: Text(
                                    "${state.cupons[index].title} / ${state.cupons[index].productDiscount.toInt()}%"),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
              WButton(
                onTap: () {
                  if (add.isNotEmpty) {
                    for (var i = 0; i < add.length; i++) {
                      context.read<AccountsBloc>().add(SelCuponPost(
                            id: add[i].id,
                            onSuccess: () {},
                            onError: (message) {
                              context.read<ShowPopUpBloc>().add(ShowPopUp(
                                  message: message, status: PopStatus.error));
                            },
                            username: widget.username,
                          ));
                    }
                  }
                  if (remove.isNotEmpty) {
                    for (var i = 0; i < remove.length; i++) {
                      context.read<AccountsBloc>().add(RemCuponPost(
                            id: remove[i].id,
                            onSuccess: () {},
                            username: widget.username,
                            onError: (message) {
                              context.read<ShowPopUpBloc>().add(ShowPopUp(
                                  message: message, status: PopStatus.error));
                            },
                          ));
                    }
                  }
                  context.read<AccountsBloc>().add(GetCupon(
                      user: state.selectAccount.selectAccount.username));
                  Navigator.of(context).pop();
                },
                isDisabled: !isChanged,
                margin: const EdgeInsets.only(top: 16),
                isLoading: state.status.isInProgress,
                text: "Tasdiqlash",
              )
            ],
          ),
        );
      },
    );
  }
}
