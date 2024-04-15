import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/common/pagination/presentation/paginator_list.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/specialist_entity.dart';
import 'package:tmed_kiosk/features/specialists/presentation/controllers/bloc/specialists_bloc.dart';

class SpecialistCatList extends StatefulWidget {
  const SpecialistCatList({super.key, this.padding, this.onTap});
  final EdgeInsets? padding;
  final Function(List<SpecialistsEntity> specialistsList)? onTap;

  @override
  State<SpecialistCatList> createState() => _SpecialistCatListState();
}

class _SpecialistCatListState extends State<SpecialistCatList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecialistsBloc, SpecialistsState>(
      builder: (context, state) {
        return PaginatorList(
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemCount: state.specialCatrs.length + 1,
          scrollDirection: Axis.horizontal,
          padding: widget.padding,
          itemBuilder: (context, index) {
            if (index == 0) {
              return GestureDetector(
                onTap: () {
                  if (state.selection != -1) {
                    context.read<SpecialistsBloc>().add(GetSpecialists(
                      onSucces: (specialistsList) {
                        if (widget.onTap != null) {
                          widget.onTap!(specialistsList);
                        }
                      },
                    ));
                    context
                        .read<SpecialistsBloc>()
                        .add(SelectionIndex(index: -1));
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: white.withOpacity(.1)),
                    color: state.selection == -1 ? blue : contColor,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Text(
                        "ALL",
                        style: AppTheme.labelSmall.copyWith(
                          color: state.selection == -1
                              ? white
                              : white.withOpacity(.5),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (state.count != 0)
                        Container(
                          height: 20,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: state.selection == -1 ? white : blue,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "${state.count}/0",
                            style: AppTheme.labelLarge.copyWith(
                                color: state.selection == -1 ? blue : white),
                          ),
                        )
                    ],
                  ),
                ),
              );
            }
            return GestureDetector(
              onTap: () {
                if (state.selection != state.specialCatrs[index - 1].id) {
                  context.read<SpecialistsBloc>().add(GetSpecialists(
                        index: state.specialCatrs[index - 1].id,
                        onSucces: (specialistsList) {
                          if (widget.onTap != null) {
                            widget.onTap!(specialistsList);
                          }
                        },
                      ));
                  context.read<SpecialistsBloc>().add(
                      SelectionIndex(index: state.specialCatrs[index - 1].id));
                }
              },
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: white.withOpacity(.1)),
                  color: state.selection == state.specialCatrs[index - 1].id
                      ? blue
                      : contColor,
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      state.specialCatrs[index - 1].name,
                      style: AppTheme.labelSmall.copyWith(
                        color:
                            state.selection == state.specialCatrs[index - 1].id
                                ? white
                                : white.withOpacity(.5),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (state.specialCatrs[index - 1].specialistCount != 0)
                      Container(
                        height: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: state.selection ==
                                  state.specialCatrs[index - 1].id
                              ? white
                              : blue,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "${state.specialCatrs[index - 1].specialistCount}/0",
                          style: AppTheme.labelLarge.copyWith(
                              color: state.selection ==
                                      state.specialCatrs[index - 1].id
                                  ? blue
                                  : white),
                        ),
                      )
                  ],
                ),
              ),
            );
          },
          paginatorStatus: state.statusP,
          fetchMoreFunction: () {},
          hasMoreToFetch: state.catCount > state.specialCatrs.length,
          errorWidget: const SizedBox(),
        );
      },
    );
  }
}
