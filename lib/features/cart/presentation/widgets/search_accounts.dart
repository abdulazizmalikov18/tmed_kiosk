import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/core/utils/formatters.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';
import 'package:tmed_kiosk/features/common/widgets/dialog_title.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/common/widgets/w_textfield.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class SearchAccount extends StatelessWidget {
  const SearchAccount({
    super.key,
    required this.vm,
    required this.bloc,
  });

  final AccountsViewModel vm;
  final AccountsBloc bloc;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountsBloc, AccountsState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            final TextEditingController controller = TextEditingController();
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                backgroundColor: context.color.backGroundColor,
                title: const DialogTitle(
                  title: "PNFl yoki telefon raqamni tering",
                ),
                content: SearchUserPNFL(controller: controller),
                actions: [
                  WButton(
                    onTap: () {
                      Log.w("Nima gap");
                      bloc.add(AccountsGet(
                        search: controller.text,
                        onSucces: (value) {
                          context.read<AccountsBloc>().add(GetCupon(
                              user: bloc
                                  .state.selectAccount.selectAccount.username));
                          context.read<MyNavigatorBloc>().add(NavId(1));
                          vm.selectAccount(
                            bloc.state.selectAccount.selectAccount,
                            false,
                          );
                        },
                        onError: () {
                          context.read<ShowPopUpBloc>().add(ShowPopUp(
                              message: "User Topilmadi",
                              status: PopStatus.error));
                        },
                      ));
                    },
                    isLoading: state.statusAccounts.isInProgress,
                    text: LocaleKeys.adduser_search.tr(),
                  )
                ],
              ),
            );
          },
          child: Container(
            height: 40,
            constraints: const BoxConstraints(maxWidth: 300),
            child: Text(
              vm.controller.text,
              style: AppTheme.displaySmall.copyWith(color: dark),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state.selectAccount.selectAccount.id != 0) {
          vm.controller.text =
              "${state.selectAccount.selectAccount.name} ${state.selectAccount.selectAccount.lastname}";
        }
      },
    );
  }
}

class SearchUserPNFL extends StatefulWidget {
  const SearchUserPNFL({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<SearchUserPNFL> createState() => _SearchUserPNFLState();
}

class _SearchUserPNFLState extends State<SearchUserPNFL> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 500,
      child: WTextField(
        height: 48,
        fillColor: context.color.borderColor,
        maxLength: widget.controller.text.contains('+') ? 13 : 14,
        keyboardType: TextInputType.phone,
        controller: widget.controller,
        inputFormatters: [Formatters.pnflFormat],
        prefix: widget.controller.text.isEmpty
            ? const SizedBox(width: 12)
            : widget.controller.text[0] == '+' ||
                    widget.controller.text.startsWith("998")
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 8,
                    ),
                    child: AppIcons.call.svg(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 8,
                    ),
                    child: AppIcons.personalcard.svg(),
                  ),
        onChanged: (value) {
          setState(() {});
        },
        hintText: 'phone_or_jshir'.tr(),
        hintStyle: const TextStyle(color: white50),
        style: TextStyle(color: context.color.white),
      ),
    );
  }
}
