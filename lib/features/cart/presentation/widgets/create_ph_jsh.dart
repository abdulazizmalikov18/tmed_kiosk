import 'package:easy_localization/easy_localization.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/core/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/common/widgets/w_textfield.dart';

class CreatePhJsh extends StatefulWidget {
  const CreatePhJsh({
    super.key,
    required this.vm,
    required this.onTap,
  });
  final AccountsViewModel vm;
  final VoidCallback onTap;

  @override
  State<CreatePhJsh> createState() => _CreatePhJshState();
}

class _CreatePhJshState extends State<CreatePhJsh> {
  String first = '';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        if (state.selectAccount.selectAccount.name.isNotEmpty) {
          widget.vm.phone.text = state.selectAccount.selectAccount.pinfl.isEmpty
              ? state.selectAccount.selectAccount.phone
              : state.selectAccount.selectAccount.pinfl;
        }
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.color.whiteBlack,
            border: Border.all(color: context.color.white.withOpacity(.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "create_account".tr(),
                style: AppTheme.displayLarge
                    .copyWith(fontSize: 20, color: context.color.white),
              ),
              const SizedBox(height: 12),
              Divider(
                color: context.color.white.withOpacity(.1),
              ),
              const SizedBox(height: 12),
              Text(
                'jshshir'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: white50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: WTextField(
                        height: 48,
                        fillColor: context.color.borderColor,
                        autoFocus: true,
                        maxLength: first == '+' ? 13 : 14,
                        keyboardType: TextInputType.phone,
                        controller: widget.vm.phone,
                        inputFormatters: [Formatters.pnflFormat],
                        enabled: !widget.vm.isChek &&
                            state.selectAccount.selectAccount.name.isEmpty,
                        prefix: widget.vm.phone.text.isEmpty
                            ? const SizedBox(width: 12)
                            : widget.vm.phone.text[0] == '+' ||
                                    widget.vm.phone.text.startsWith("998")
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                      left: 12,
                                      right: 8,
                                    ),
                                    child: SvgPicture.asset(
                                      AppIcons.call,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                      left: 12,
                                      right: 8,
                                    ),
                                    child: SvgPicture.asset(
                                      AppIcons.personalcard,
                                    ),
                                  ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            first = value[0];
                          } else {
                            first = '';
                          }

                          setState(() {});
                        },
                        hintText: 'phone_or_jshir'.tr(),
                        hintStyle: const TextStyle(color: white50),
                        style: TextStyle(color: context.color.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: WButton(
                        height: 48,
                        isDisabled: !(widget.vm.phone.text.startsWith("+998")
                                ? widget.vm.phone.text.length == 13
                                : widget.vm.phone.text.length == 14) ||
                            widget.vm.isChek,
                        onTap: widget.onTap,
                        text: "adduser_phone_button".tr(),
                        isLoading: state.status.isInProgress,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
