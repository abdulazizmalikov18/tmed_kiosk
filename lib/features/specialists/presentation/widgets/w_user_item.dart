import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/constants/images.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/common/navigation/presentation/navigator.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/specialist_entity.dart';
import 'package:tmed_kiosk/features/specialists/presentation/views/selection_spec_phone.dart';
import 'package:tmed_kiosk/features/specialists/presentation/views/selection_specialists_view.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class WUserItem extends StatelessWidget {
  const WUserItem({super.key, this.isAvtion = false, required this.user});
  final bool isAvtion;
  final SpecialistsEntity user;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        context.read<GoodsBloc>().add(GetSpecialistPro(user.id));
        if (size >= 601) {
          Navigator.push(context, fade(page: const SelectSpecialistView()));
        } else {
          Navigator.push(
            context,
            fade(
              page: SelectSpecialPhone(text: '${user.name} ${user.lastname}'),
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: isAvtion ? 16 : 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.color.contColor,
          boxShadow: wboxShadow,
          border: Border.all(color: context.color.white.withOpacity(.1)),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(120),
              child: SizedBox(
                height: 40,
                width: 40,
                child: Image.network(
                  user.avatar,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset(AppImages.user),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user.name} ${user.lastname}",
                    style: AppTheme.displayLarge.copyWith(color: context.color.white),
                  ),
                  Text(
                    user.job.name,
                    style: AppTheme.labelLarge.copyWith(color: context.color.white50),
                  ),
                  Text(
                    user.phone.isEmpty ? "--" : user.phone,
                    style: AppTheme.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      text: "${LocaleKeys.working_time.tr()}:",
                      style: AppTheme.labelLarge,
                      children: [
                        TextSpan(
                          text:
                              " ${MyFunctions.clockform(user.todayTimetable.startTime)}-${MyFunctions.clockform(user.todayTimetable.endTime)}",
                          style: AppTheme.labelSmall.copyWith(color: context.color.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (user.orderCount != 0)
              Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: blue,
                ),
                child: Center(
                  child: Text(
                    user.orderCount.toString(),
                    style: AppTheme.labelLarge.copyWith(color: white),
                  ),
                ),
              ),
          ],
        ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Row(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         const Spacer(flex: 5),
        //         Center(
        //           child: ClipRRect(
        //             borderRadius: BorderRadius.circular(120),
        //             child: SizedBox(
        //               height: 120,
        //               width: 120,
        //               child: Image.network(
        //                 user.avatar,
        //                 fit: BoxFit.cover,
        //                 errorBuilder: (context, error, stackTrace) => Image.asset(AppImages.user),
        //               ),
        //             ),
        //           ),
        //         ),
        //         const Spacer(flex: 3),
        //         Container(
        //           height: 48,
        //           width: 48,
        //           decoration: const BoxDecoration(
        //             shape: BoxShape.circle,
        //             color: green,
        //           ),
        //           child: Center(
        //             child: Text(
        //               user.orderCount.toString(),
        //               style: AppTheme.bodyMedium.copyWith(color: white, fontWeight: FontWeight.w400),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.symmetric(vertical: 8),
        //       child: Text(
        //         '${user.name} ${user.lastname}',
        //         style: const TextStyle(
        //           fontSize: 18,
        //           fontWeight: FontWeight.w500,
        //         ),
        //       ),
        //     ),
        //     const Divider(
        //       color: whiteGrey,
        //       height: 1,
        //     ),
        //     Container(
        //       padding: const EdgeInsets.only(top: 8.0),
        //       height: 30,
        //       alignment: Alignment.centerLeft,
        //       child: Text(
        //         user.job.name,
        //         style: const TextStyle(fontSize: 16, color: greyText),
        //       ),
        //     ),
        //     Container(
        //       height: 30,
        //       alignment: Alignment.centerLeft,
        //       child: Text(
        //         'Ish vaqti: ${MyFunctions.clockform(user.todayTimetable.startTime)}-${MyFunctions.clockform(user.todayTimetable.endTime)}',
        //         style: const TextStyle(fontSize: 16, color: greyText),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
