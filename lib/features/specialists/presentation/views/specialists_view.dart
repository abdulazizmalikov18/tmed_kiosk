import 'package:easy_localization/easy_localization.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/specialists/presentation/views/specialists_phone_view.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/common/pagination/presentation/paginator.dart';
import 'package:tmed_kiosk/features/common/widgets/nwe_appbar.dart';
import 'package:tmed_kiosk/features/common/widgets/w_search_button.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/no_data_cart.dart';
import 'package:tmed_kiosk/features/specialists/presentation/controllers/bloc/specialists_bloc.dart';
import 'package:tmed_kiosk/features/specialists/presentation/widgets/special_shimmer_iteam.dart';
import 'package:tmed_kiosk/features/specialists/presentation/widgets/specialist_cat_list.dart';
import 'package:tmed_kiosk/features/specialists/presentation/widgets/w_user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecialistsView extends StatefulWidget {
  const SpecialistsView({super.key});

  @override
  State<SpecialistsView> createState() => _SpecialistsViewState();
}

class _SpecialistsViewState extends State<SpecialistsView> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.sizeOf(context).width < 800) {
      return SpecialistPhoneView(vm: AccountsViewModel(), vmC: CartViewModel());
    }
    return Scaffold(
      backgroundColor: context.color.backGroundColor,
      appBar: NewAppBar(
        title: "offer_description_specialist".tr(),
        child: Row(
          children: [
            const Expanded(child: SpecialistCatList()),
            const SizedBox(width: 16),
            WSearchButton(
              controller: controller,
              onEditingComplete: () {
                context
                    .read<SpecialistsBloc>()
                    .add(GetSpecialists(search: controller.text));
              },
              onChanged: (String value) {},
            )
          ],
        ),
      ),
      body: BlocBuilder<SpecialistsBloc, SpecialistsState>(
        builder: (context, state) {
          return BlocBuilder<MyNavigatorBloc, MyNavigatorState>(
            builder: (context, stateN) {
              if (state.status.isInProgress) {
                return GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 112,
                    maxCrossAxisExtent: stateN.openCart ? 700 : 440,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) => const SpecialShimmerIteam(),
                );
              } else {
                if (state.specialistsList.isEmpty) {
                  return Center(
                    child: NoDataCart(
                      image: AppIcons.noData,
                      title: 'nothing_have'.tr(),
                      isButton: true,
                    ),
                  );
                } else {
                  return Paginator(
                    padding: const EdgeInsets.all(20),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: 112,
                      maxCrossAxisExtent: stateN.openCart ? 700 : 440,
                    ),
                    itemCount: state.specialistsList.length,
                    itemBuilder: (context, index) =>
                        WUserItem(user: state.specialistsList[index]),
                    errorWidget: const SizedBox(),
                    fetchMoreFunction: () {
                      context.read<SpecialistsBloc>().add(GetMoreSpecialists());
                    },
                    loadingWidget: const SpecialShimmerIteam(),
                    hasMoreToFetch: state.count > state.specialistsList.length,
                    paginatorStatus: state.statusP,
                  );
                }
              }
            },
          );
        },
      ),
    );
  }
}
