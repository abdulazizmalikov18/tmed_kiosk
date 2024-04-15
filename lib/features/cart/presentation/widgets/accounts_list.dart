import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/accounts_list_tile.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/accounts_shimmer.dart';
import 'package:tmed_kiosk/features/common/pagination/presentation/paginator_list.dart';

class AccountsList extends StatelessWidget {
  const AccountsList({super.key, this.isPhone = false, required this.vm});
  final bool isPhone;
  final AccountsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          color: contColor,
          child: Builder(builder: (context) {
            if (state.statusAccounts.isInProgress) {
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => const AccountsShimmer(),
              );
            } else {
              if (state.accounts.isNotEmpty) {
                return PaginatorList(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: state.accounts.length,
                  itemBuilder: (context, index) => AccountsListTile(
                    vm: vm,
                    isPhone: isPhone,
                    entity: state.accounts[index],
                  ),
                  paginatorStatus: state.statusAccounts,
                  fetchMoreFunction: () {
                    context.read<AccountsBloc>().add(GetMoreAccounts(
                        search: vm.controller.text.isEmpty
                            ? null
                            : vm.controller.text));
                  },
                  loadingWidget: const AccountsShimmer(),
                  hasMoreToFetch: state.count > state.accounts.length,
                  errorWidget: const SizedBox(),
                );
              } else {
                return SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(child: SvgPicture.asset(AppIcons.noData)),
                );
              }
            }
          }),
        );
      },
    );
  }
}
