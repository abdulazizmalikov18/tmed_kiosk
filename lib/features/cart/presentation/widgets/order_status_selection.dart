import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/process_status_entity.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';

class OrderStatusSelection extends StatelessWidget {
  const OrderStatusSelection({super.key, required this.state});
  final CartState state;

  @override
  Widget build(BuildContext context) {
    final size = MyFunctions.paddingRespons(MediaQuery.sizeOf(context).height);
    return Container(
      decoration: wdecoration2,
      padding: EdgeInsets.all(size),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Status",
            style: AppTheme.bodyLarge,
          ),
          SizedBox(height: size),
          SizedBox(
            height: 40,
            child: DropdownButtonFormField<ProcessStatusEntity>(
              value: state.selStatus,
              icon: AppIcons.arrowDown.svg(color: white.withOpacity(.5)),
              decoration: InputDecoration(
                fillColor: const Color(0xFF414D5E),
                focusColor: const Color(0xFF414D5E),
                hoverColor: const Color(0xFF414D5E),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: white.withOpacity(.5)),
                ),
              ),
              borderRadius: BorderRadius.circular(12),
              dropdownColor: contColor,
              items: state.processStatus.map((ProcessStatusEntity value) {
                return DropdownMenuItem<ProcessStatusEntity>(
                  value: value,
                  child: Text(
                    value.name,
                    style: AppTheme.labelLarge
                        .copyWith(color: white.withOpacity(.5)),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                Log.w(newValue);
                context.read<CartBloc>().add(SelStatus(selStatus: newValue!));
              },
            ),
          ),
        ],
      ),
    );
  }
}
