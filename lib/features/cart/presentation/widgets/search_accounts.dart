import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';
import 'package:tmed_kiosk/features/common/widgets/w_scale_animation.dart';
import 'package:tmed_kiosk/features/common/widgets/z_text_form_field.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class SearchAccount extends StatelessWidget {
  const SearchAccount({
    super.key,
    required this.vm,
  });

  final AccountsViewModel vm;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountsBloc, AccountsState>(
      builder: (context, state) {
        return Focus(
          onFocusChange: (focused) {
            if (focused) {
              Log.w("Bir");
              context.read<MyNavigatorBloc>().add(NavId(6));
            }
            if (!state.isFocused &&
                context.read<CartBloc>().state.isOrder.isEmpty) {
              Log.w("Ikki");
              context.read<AccountsBloc>().add(IsFocused(isFocused: focused));
            }
          },
          child: Container(
            height: 40,
            constraints: const BoxConstraints(maxWidth: 300),
            child: ZTextFormField(
              onChanged: (value) {
                context.read<AccountsBloc>().add(AccountsGet(search: value));
              },
              fillColor: context.color.whiteBlack,
              prefixIcon: IconButton(
                onPressed: () {},
                icon: AppIcons.search.svg(color: white50),
              ),
              controller: vm.controller,
              suffixIcon: "a",
              enabled: context.read<CartBloc>().state.isOrder.isEmpty,
              suffix: state.isFocused ||
                      state.selectAccount.selectAccount.id != 0 &&
                          context.read<CartBloc>().state.isOrder.isEmpty
                  ? WScaleAnimation(
                      onTap: () {
                        context.read<MyNavigatorBloc>().add(NavId(0));
                        context
                            .read<AccountsBloc>()
                            .add(IsFocused(isFocused: false));
                        vm.clearAccount(context);
                      },
                      child: const Icon(Icons.close_rounded, color: white50,),
                    )
                  : null,
              hintText: LocaleKeys.adduser_search.tr(),
            ),
          ),
          // child: Container(
          //   constraints: const BoxConstraints(maxWidth: 360),
          //   child: TextField(
          //     controller: vm.controller,
          //     enabled: context.read<CartBloc>().state.isOrder.isEmpty,
          //     decoration: InputDecoration(
          //       hintText: LocaleKeys.adduserSearch.tr(),
          //       hintStyle: Theme.of(context).textTheme.bodyLarge,
          //       border: InputBorder.none,
          //       prefixIcon: IconButton(
          //         onPressed: () {},
          //         icon: AppIcons.search.svg(),
          //       ),
          //       contentPadding: const EdgeInsets.only(top: 16),
          //       prefixIconConstraints: const BoxConstraints(maxWidth: 70),
          //       suffixIcon: state.isFocused || state.selectAccount.selectAccount.name.isNotEmpty
          //           ? WScaleAnimation(
          //               onTap: () {
          //                 context.read<AccountsBloc>().add(IsFocused(isFocused: false));
          //                 vm.clearAccount(context);
          //               },
          //               child: const Icon(Icons.close_rounded))
          //           : null,
          //     ),
          //     maxLines: 1,
          //     onChanged: (value) {
          //       context.read<AccountsBloc>().add(AccountsGet(search: value));
          //     },
          //   ),
          // ),
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
