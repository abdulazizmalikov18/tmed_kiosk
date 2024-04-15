import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/specialist_entity.dart';

class WPSPIteam extends StatelessWidget {
  const WPSPIteam({
    super.key,
    required this.isSelect,
    required this.specialist,
  });

  final bool isSelect;
  final SpecialistsEntity specialist;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSelect ? blue.withOpacity(.2) : contColor,
        boxShadow: wboxShadow,
        border: isSelect
            ? Border.all(color: blue)
            : Border.all(color: white.withOpacity(.1)),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Container(
              height: 60,
              width: 60,
              color: greyText,
              child: Image.network(
                specialist.avatar,
                errorBuilder: (context, error, stackTrace) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: SvgPicture.asset(AppIcons.dwedLogo),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  specialist.name,
                  style: AppTheme.bodyMedium,
                ),
                Text(
                  specialist.job.name,
                  style: AppTheme.labelSmall,
                  overflow: TextOverflow.ellipsis,
                ),
                RichText(
                  maxLines: 1,
                  text: TextSpan(
                    text: 'Ish vaqti turi:',
                    style: AppTheme.labelSmall,
                    children: [
                      TextSpan(
                        text: specialist.experience,
                        style: AppTheme.labelSmall
                            .copyWith(fontSize: 16, color: white),
                      ),
                    ],
                  ),
                ),
                RichText(
                  maxLines: 1,
                  text: TextSpan(
                    text: 'Ish vaqti: ',
                    style: AppTheme.labelSmall,
                    children: [
                      TextSpan(
                        text:
                            '${MyFunctions.clockform(specialist.todayTimetable.startTime)}-${MyFunctions.clockform(specialist.todayTimetable.endTime)}',
                        style: AppTheme.labelSmall
                            .copyWith(fontSize: 16, color: white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
