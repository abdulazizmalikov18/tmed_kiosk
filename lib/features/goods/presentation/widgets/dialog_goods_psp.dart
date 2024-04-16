import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class DialogGoodsPsp extends StatelessWidget {
  const DialogGoodsPsp({super.key, required this.bloc});
  final GoodsBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoodsBloc, GoodsState>(
      bloc: bloc,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                "${LocaleKeys.general_information.tr()}:",
                style: AppTheme.bodyLarge.copyWith(color: context.color.white),
              ),
            ),
            SizedBox(
              height: 196,
              child: Builder(
                builder: (context) {
                  if (state.status2.isInProgress) {
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
                      itemCount: 6,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) => SizedBox(
                        width: 150,
                        height: 180,
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
                    );
                  } else {
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
                      itemCount: state.psp.length,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: contColor,
                          boxShadow: wboxShadow,
                          border: Border.all(color: white.withOpacity(.1)),
                        ),
                        padding: const EdgeInsets.all(12),
                        width: 150,
                        child: Column(
                          children: [
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  color: greyText,
                                  child: Image.network(
                                    state.psp[index].specialist.avatar,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, url, error) =>
                                        Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child:
                                          SvgPicture.asset(AppIcons.dwedLogo),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${state.psp[index].specialist.name} ${state.psp[index].specialist.lastname}",
                              style: AppTheme.bodyLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              state.psp[index].specialist.specCat.name,
                              style: AppTheme.labelSmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
