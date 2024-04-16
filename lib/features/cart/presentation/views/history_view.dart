import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/common/widgets/w_text_gard.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/no_data_cart.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:shimmer/shimmer.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key, required this.vm, this.isPhone = false});
  final AccountsViewModel vm;
  final bool isPhone;

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: widget.isPhone ? AppBar(title: const Text("History")) : null,
      body: BlocBuilder<AccountsBloc, AccountsState>(
        builder: (context, state) {
          if (state.status.isInProgress) {
            return Column(
              children: [
                Container(
                  height: 48,
                  margin: const EdgeInsets.all(16),
                  child: Shimmer.fromColors(
                    baseColor: blue.withOpacity(0.13),
                    highlightColor: blue.withOpacity(0.01),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: blue,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 8,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) => Container(
                      height: 94,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Shimmer.fromColors(
                        baseColor: blue.withOpacity(0.13),
                        highlightColor: blue.withOpacity(0.01),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state.historys.isNotEmpty) {
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: contColor,
                  ),
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        height: 32,
                        width: 32,
                        padding: const EdgeInsets.only(right: 12),
                        child: AppIcons.receiptSearch.svg(
                          height: 32,
                          width: 32,
                        ),
                      ),
                      Text(
                        "History: ${state.historys.length}",
                        style: AppTheme.bodyLarge
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      const Spacer(),
                      SvgPicture.asset(AppIcons.sort)
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.historys.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) => Container(
                      height: widget.isPhone ? 100 : 94,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: contColor,
                      ),
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth: size.width / 2 - 38),
                                child: Text(
                                  state.historys[index].name,
                                  style: AppTheme.bodyMedium
                                      .copyWith(fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              if (state.historys[index].currentWorkState
                                  .specialist.name.isNotEmpty)
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 20),
                                  child: Text(
                                    " / ",
                                    style: AppTheme.bodyMedium
                                        .copyWith(fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              if (state.historys[index].currentWorkState
                                  .specialist.name.isNotEmpty)
                                Container(
                                  constraints:
                                      BoxConstraints(maxWidth: size.width / 2),
                                  child: WTextGrad(
                                    fontSize: 18,
                                    text:
                                        "${state.historys[index].currentWorkState.specialist.name} ${state.historys[index].currentWorkState.specialist.lastname}",
                                  ),
                                )
                            ],
                          ),
                          const Divider(color: whiteGrey),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "${LocaleKeys.status_order_status_action.tr()}:${state.historys[index].unit.name}",
                                    style: AppTheme.labelSmall
                                        .copyWith(fontSize: 16),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "x 1 ${state.historys[index].unit.name}",
                                    style: AppTheme.labelSmall
                                        .copyWith(fontSize: 16),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    state.historys[index].meetDate.isNotEmpty
                                        ? MyFunctions.getformDate(
                                            state.historys[index].meetDate)
                                        : '',
                                    style: AppTheme.labelSmall
                                        .copyWith(fontSize: 16),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: NoDataCart(
                image: AppIcons.noData,
                title: 'Nothing have',
                isButton: false,
              ),
            );
          }
        },
      ),
    );
  }
}
