import 'package:tmed_kiosk/features/common/navigation/routs_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/widgets/dialog_title.dart';
import 'package:tmed_kiosk/features/common/widgets/w_scale_animation.dart';
import 'package:tmed_kiosk/features/common/widgets/w_text_gard.dart';
import 'package:go_router/go_router.dart';

class RetseptDialog extends StatelessWidget {
  const RetseptDialog({super.key, this.isPhone = false});
  final bool isPhone;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        return SizedBox(
          width: 652,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const DialogTitle(title: 'Receipt/Recommendation'),
              const SizedBox(height: 8),
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (state.statusd.isInProgress) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${state.recommendations[index].specialist.name} ${state.recommendations[index].specialist.lastname}",
                                    style: AppTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    state.recommendations[index].specialist.job,
                                    style: AppTheme.bodyLarge,
                                  ),
                                  if (isPhone)
                                    WScaleAnimation(
                                      onTap: () {
                                        context
                                            .read<CartBloc>()
                                            .add(CartAddRecommendation(
                                              products: state
                                                  .recommendations[index]
                                                  .products,
                                              onSuccess: () {
                                                Navigator.pop(context);
                                                context.go(RoutsContact.goods);
                                              },
                                              onError: (error) {},
                                            ));
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        height: 48,
                                        margin: const EdgeInsets.only(top: 12),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: white,
                                          boxShadow: wboxShadow,
                                        ),
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 12),
                                        child: WTextGrad(
                                          text:
                                              "12 Reciept, Date ${MyFunctions.parseDate(state.recommendations[index].createDate)}",
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                            if (!isPhone)
                              WScaleAnimation(
                                onTap: () {
                                  context
                                      .read<CartBloc>()
                                      .add(CartAddRecommendation(
                                        products: state
                                            .recommendations[index].products,
                                        onSuccess: () {
                                          Navigator.pop(context);
                                          context.go(RoutsContact.goods);
                                        },
                                        onError: (error) {
                                          context.read<ShowPopUpBloc>().add(
                                              ShowPopUp(
                                                  message: "Malumot topilmadi",
                                                  status: PopStatus.warning));
                                        },
                                      ));
                                },
                                child: Container(
                                  height: 48,
                                  width: 420,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: white,
                                    boxShadow: wboxShadow,
                                  ),
                                  margin: const EdgeInsets.only(left: 16),
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: WTextGrad(
                                    text:
                                        "12 Reciept, Date ${MyFunctions.parseDate(state.recommendations[index].createDate)}",
                                  ),
                                ),
                              )
                          ],
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 24),
                        itemCount: state.recommendations.length,
                      );
                    }
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
