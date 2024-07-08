// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/core/utils/formatters.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_model.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/profession_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/region_entity.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/user_bottom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/constants/images.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/cupon/cupon_dialog.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/gender_drop_down.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/profession/profession_dalog.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/region/region_dialog.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/user_camera.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/user_camera_macos.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/widgets/w_scale_animation.dart';
import 'package:tmed_kiosk/features/common/widgets/w_textfield.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';

part 'package:tmed_kiosk/features/cart/presentation/controllers/add_user_contoller_phone.dart';

class AddUsetIteamPhone extends StatefulWidget {
  const AddUsetIteamPhone({
    super.key,
    required this.vm,
    required this.onTap,
    this.images,
  });

  final VoidCallback onTap;
  final File? images;
  final AccountsViewModel vm;

  @override
  State<AddUsetIteamPhone> createState() => _AddUsetIteamPhoneState();
}

class _AddUsetIteamPhoneState extends State<AddUsetIteamPhone>
    with AddUserViweModel {
  Widget buildDatePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          minimumYear: 1900,
          maximumYear: DateTime.now().year,
          initialDateTime: selectedDate,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) {
            selectedDate = dateTime;
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WScaleAnimation(
                      onTap: widget.onTap,
                      child: widget.images == null
                          ? Container(
                              height: 100,
                              width: 100,
                              margin: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: greyText),
                                image: state.selectAccount.selectAccount.avatar
                                        .isNotEmpty
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          state.selectAccount.selectAccount
                                              .avatar[0],
                                        ),
                                        onError: (exception, stackTrace) =>
                                            Image.asset(AppImages.logo),
                                      )
                                    : null,
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(AppIcons.camera),
                            )
                          : Container(
                              height: 100,
                              width: 100,
                              margin: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: greyText),
                                image: DecorationImage(
                                  image: FileImage(
                                    widget.images!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                    Column(
                      children: [
                        WTextField(
                          height: 56,
                          textCapitalization: TextCapitalization.words,
                          onChanged: (value) {
                            widget.vm.name.value = TextEditingValue(
                              text: Formatters.capitalize(value),
                              selection: widget.vm.name.selection,
                            );
                            // changeInfo();
                          },
                          inputFormatters: [Formatters.lotinFormat],
                          enabled:
                              state.selectAccount.selectAccount.status != 2,
                          hintText: "Name*",
                          controller: widget.vm.name,
                        ),
                        const SizedBox(height: 12),
                        WTextField(
                          height: 56,
                          enabled:
                              state.selectAccount.selectAccount.status != 2,
                          onChanged: (value) {
                            widget.vm.latname.value = TextEditingValue(
                              text: Formatters.capitalize(value),
                              selection: widget.vm.latname.selection,
                            );
                            // changeInfo();
                          },
                          inputFormatters: [Formatters.lotinFormat],
                          hintText: "Surname*",
                          controller: widget.vm.latname,
                        ),
                        const SizedBox(height: 12),
                        InkWell(
                          onTap: () {
                            MyFunctions.showSheet(
                              context,
                              child: buildDatePicker(),
                              onClicked: () {
                                widget.vm.age.text =
                                    MyFunctions.formattedDate(selectedDate);
                                setState(() {});
                                Navigator.pop(context);
                              },
                            );
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              border: Border.all(color: greyText),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                Text(
                                  widget.vm.age.text.isNotEmpty
                                      ? widget.vm.age.text
                                      : "Age*",
                                  style: AppTheme.labelSmall
                                      .copyWith(fontSize: 16, color: white),
                                ),
                                const Spacer(),
                                SvgPicture.asset(AppIcons.calendarEdit)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 48,
                          child: GenderDropDown(
                            controller: widget.vm.gender,
                            onChange: () {},
                            isDisebled:
                                state.selectAccount.selectAccount.status != 2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.all(16),
                                insetPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                content: BlocProvider(
                                  create: (context) => AccountsBloc(),
                                  child: RegionDialog(vm: widget.vm),
                                ),
                              ),
                            ).then((value) {
                              if (value is RegionEntity) {
                                widget.vm.region.text = value.name;
                                widget.vm.regionEntity = value;
                                setState(() {});
                              }
                            });
                          },
                          child: Container(
                            height: 48,
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              border: Border.all(color: greyText),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              widget.vm.region.text.isNotEmpty
                                  ? widget.vm.region.text
                                  : "Region",
                              style: AppTheme.labelSmall.copyWith(
                                fontSize: 16,
                                color: widget.vm.region.text.isNotEmpty
                                    ? white
                                    : greyText,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () {
                            context.read<AccountsBloc>().add(GetProfession());
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                insetPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                contentPadding: const EdgeInsets.all(16),
                                content: BlocProvider(
                                  create: (context) => AccountsBloc(),
                                  child: ProfessionDialog(vm: widget.vm),
                                ),
                              ),
                            ).then((value) {
                              if (value is ProfessionEntity) {
                                widget.vm.profession.text = value.name;
                                widget.vm.professionEntity = value;
                                setState(() {});
                              }
                            });
                          },
                          child: Container(
                            height: 48,
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              border: Border.all(color: greyText),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              widget.vm.profession.text.isNotEmpty
                                  ? widget.vm.profession.text
                                  : "Profession",
                              style: AppTheme.labelSmall.copyWith(
                                fontSize: 16,
                                color: widget.vm.profession.text.isNotEmpty
                                    ? white
                                    : greyText,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Builder(builder: (context) {
                          widget.vm.cupon.text = state.selectAccount.cupons
                              .map((e) => e.title)
                              .toList()
                              .join(', ');
                          return InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  contentPadding: const EdgeInsets.all(16),
                                  content: BlocProvider(
                                    create: (context) => AccountsBloc(),
                                    child: CuponDialog(
                                        vm: widget.vm,
                                        cupons: state.selectAccount.cupons,
                                        username: state.selectAccount
                                            .selectAccount.username),
                                  ),
                                ),
                              ).then((value) {
                                setState(() {});
                              });
                            },
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                border: Border.all(color: greyText),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.vm.cupon.text.isNotEmpty
                                          ? widget.vm.cupon.text
                                          : "Coupon",
                                      style: AppTheme.labelSmall.copyWith(
                                        fontSize: 16,
                                        color: white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  SvgPicture.asset(AppIcons.discount)
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            UserBottomButton(vm: widget.vm, images: widget.images)
          ],
        );
      },
    );
  }
}
