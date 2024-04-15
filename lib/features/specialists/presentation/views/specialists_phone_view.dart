import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/common/pagination/presentation/paginator_list.dart';
import 'package:tmed_kiosk/features/common/widgets/w_appbar_ph.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/no_data_cart.dart';
import 'package:tmed_kiosk/features/specialists/presentation/controllers/bloc/specialists_bloc.dart';
import 'package:tmed_kiosk/features/specialists/presentation/widgets/special_shimmer_iteam.dart';
import 'package:tmed_kiosk/features/specialists/presentation/widgets/specialist_cat_list.dart';
import 'package:tmed_kiosk/features/specialists/presentation/widgets/w_user_item.dart';

class SpecialistPhoneView extends StatefulWidget {
  const SpecialistPhoneView({super.key, required this.vm, required this.vmC});
  final AccountsViewModel vm;
  final CartViewModel vmC;

  @override
  State<SpecialistPhoneView> createState() => _SpecialistPhoneViewState();
}

class _SpecialistPhoneViewState extends State<SpecialistPhoneView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WAppBarPhone(
        vmC: widget.vmC,
        onChanged: (value) {
          context.read<SpecialistsBloc>().add(GetSpecialists(search: value));
        },
        isQrcode: true,
        child: const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 0, 8),
          child: SpecialistCatList(),
        ),
      ),
      body: BlocBuilder<SpecialistsBloc, SpecialistsState>(
        builder: (context, state) {
          if (state.status.isInProgress) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 256,
                maxCrossAxisExtent: 440,
              ),
              itemCount: 10,
              itemBuilder: (context, index) => const SpecialShimmerIteam(),
            );
          } else {
            if (state.specialistsList.isEmpty) {
              return const Center(
                child: NoDataCart(
                  image: AppIcons.noData,
                  title: 'Nothing have',
                  isButton: true,
                ),
              );
            } else {
              return PaginatorList(
                padding: const EdgeInsets.all(16),
                itemCount: state.specialistsList.length,
                itemBuilder: (context, index) =>
                    WUserItem(user: state.specialistsList[index]),
                errorWidget: const SizedBox(),
                fetchMoreFunction: () {
                  context.read<SpecialistsBloc>().add(GetMoreSpecialists());
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                loadingWidget: const SpecialShimmerIteam(),
                hasMoreToFetch: state.count > state.specialistsList.length,
                paginatorStatus: state.statusP,
              );
            }
          }
        },
      ),
    );
  }
}
