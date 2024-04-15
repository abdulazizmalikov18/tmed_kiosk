import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/common/widgets/w_scale_animation.dart';
import 'package:tmed_kiosk/features/specialists/presentation/controllers/bloc/specialists_bloc.dart';
import 'package:shimmer/shimmer.dart';

class SpecialListIteam extends StatelessWidget {
  const SpecialListIteam({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecialistsBloc, SpecialistsState>(
      builder: (context, state) {
        if (state.statusP.isSuccess) {
          return ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            children: [
              WScaleAnimation(
                onTap: () {
                  context
                      .read<SpecialistsBloc>()
                      .add(SelectionIndex(index: -1));
                  context.read<SpecialistsBloc>().add(GetSpecialists());
                },
                child: Container(
                  height: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: state.selection == -1
                        ? null
                        : Border.all(color: whiteGrey),
                    color: state.selection == -1 ? blue : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "ALL",
                    style: AppTheme.labelSmall.copyWith(
                      color: state.selection == -1 ? white : greyText,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ...List.generate(
                state.specialCatrs.length,
                (index) => WScaleAnimation(
                  onTap: () {
                    context
                        .read<SpecialistsBloc>()
                        .add(SelectionIndex(index: index));
                    context.read<SpecialistsBloc>().add(
                        GetSpecialists(index: state.specialCatrs[index].id));
                  },
                  child: Container(
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: white.withOpacity(.1)),
                      color: state.selection == index ? blue : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      state.specialCatrs[index].name,
                      style: AppTheme.labelSmall.copyWith(
                        color: state.selection == index
                            ? white
                            : white.withOpacity(.5),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        } else {
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => SizedBox(
              width: 88,
              height: 30,
              child: Shimmer.fromColors(
                baseColor: blue.withOpacity(0.13),
                highlightColor: blue.withOpacity(0.01),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: blue,
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
