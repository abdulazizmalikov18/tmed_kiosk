import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/images.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/accounts_entity.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';

class AccountsListTile extends StatelessWidget {
  const AccountsListTile({
    super.key,
    required this.vm,
    required this.isPhone,
    required this.entity,
  });

  final AccountsViewModel vm;
  final bool isPhone;
  final AccountsEntity entity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.read<AccountsBloc>().add(SelectionAccount(account: entity));
        context.read<AccountsBloc>().add(GetCupon(user: entity.username));
        context.read<AccountsBloc>().add(IsFocused(isFocused: false));
        if (Platform.isWindows || Platform.isMacOS) {
          context.read<MyNavigatorBloc>().add(NavId(1));
        }
        vm.selectAccount(entity, false);
      },
      title: isPhone
          ? Text(
              "${entity.name} ${entity.lastname}",
              style: AppTheme.bodyLarge,
            )
          : Text(
              "${entity.name} ${entity.lastname}/ ${entity.region.name}/${MyFunctions.getShifrPhone(entity.phone)}"),
      subtitle: isPhone
          ? Text(
              "${entity.region.name}/${MyFunctions.getShifrPhone(entity.phone)}",
              style: AppTheme.labelSmall,
            )
          : null,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(48),
        child: Container(
          height: 48,
          width: 48,
          color: greyText,
          child: Image.network(
            entity.avatar.isNotEmpty ? entity.avatar[0] : '',
            fit: BoxFit.cover,
            errorBuilder: (context, url, error) => Image.asset(AppImages.user),
          ),
        ),
      ),
    );
  }
}
