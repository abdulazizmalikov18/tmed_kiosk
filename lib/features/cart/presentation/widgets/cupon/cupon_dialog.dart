import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/core/utils/debounce.dart';
import 'package:tmed_kiosk/features/common/pagination/presentation/paginator_list.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';
import 'package:tmed_kiosk/features/common/widgets/w_textfield.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_model.dart';
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
  final List<CuponModel> cupons;
  final String username;

  @override
  State<CuponDialog> createState() => _CuponDialogState();
}

class _CuponDialogState extends State<CuponDialog> {
  List<CuponModel> cupons = [];
  List<CuponModel> remove = [];
  List<CuponModel> add = [];
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DialogTitle(title: "adduser_coupon_title".tr()),
                const SizedBox(height: 8),
                WTextField(
                  onChanged: (value) {
                    onDebounce(() {
                      context.read<AccountsBloc>().add(GetCupon(search: value));
                    });
                  },
                  cursorHeight: 30,
                  contentPadding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                  hintText: LocaleKeys.offerpage_search.tr(),
                  suffix: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: AppIcons.search.svg(),
                  ),
                  fillColor: context.color.contColor,
                  style: TextStyle(color: context.color.white),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: contColor.withOpacity(.1),
                      ),
                    ),
                    height: 400,
                    child: Builder(
                      builder: (context) {
                        if (state.status.isInProgress) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return PaginatorList(
                            itemCount: state.cupons.length,
                            itemBuilder: (context, index) {
                              final isSelec = widget.cupons
                                  .where((element) =>
                                      element.id == state.cupons[index].id)
                                  .isNotEmpty;
                              var isSelection = cupons
                                  .where((element) =>
                                      element.id == state.cupons[index].id)
                                  .isNotEmpty;
                              return InkWell(
                                onTap: () {
                                  if (isSelection) {
                                    final ball = widget.cupons
                                        .where((element) =>
                                            element.id ==
                                            state.cupons[index].id)
                                        .isNotEmpty;
                                    if (ball) {
                                      remove.add(state.cupons[index]);
                                    }
                                    add.remove(state.cupons[index]);
                                    cupons.removeWhere(
                                      (element) =>
                                          element.id == state.cupons[index].id,
                                    );
                                  } else {
                                    if (!isSelec) {
                                      add.add(state.cupons[index]);
                                    }
                                    remove.remove(state.cupons[index]);
                                    cupons.add(state.cupons[index]);
                                  }
                                  Log.d("Salom gap $cupons");
                                  Log.d("Add gap $add");
                                  Log.d("Remove gap $remove");
                                  isChanged = true;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: cupons
                                            .where((element) =>
                                                element.id ==
                                                state.cupons[index].id)
                                            .isNotEmpty
                                        ? blue
                                        : Colors.transparent,
                                    border: Border(
                                        bottom: BorderSide(
                                            color: contColor.withOpacity(.1))),
                                  ),
                                  child: Text(
                                    "${state.cupons[index].title} / ${state.cupons[index].productDiscount.toInt()}%",
                                    style: TextStyle(
                                      color: isSelection
                                          ? white
                                          : context.color.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                            paginatorStatus: state.status,
                            hasMoreToFetch:
                                state.countCupon > state.cupons.length,
                            fetchMoreFunction: () {
                              context
                                  .read<AccountsBloc>()
                                  .add(GetCupon(feetchMore: true));
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
                WButton(
                  onTap: () async {
                    if (add.isNotEmpty) {
                      for (var i = 0; i < add.length; i++) {
                        context.read<AccountsBloc>().add(SelCuponPost(
                              id: add[i].id,
                              onSuccess: () {
                                if (i == add.length - 1) {
                                  context.read<AccountsBloc>().add(GetCupon(
                                      user: state.selectAccount.selectAccount
                                          .username));
                                }
                              },
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

                    Navigator.of(context).pop();
                  },
                  isDisabled: !isChanged,
                  margin: const EdgeInsets.only(top: 16),
                  isLoading: state.status.isInProgress,
                  text: "confirmation".tr(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
