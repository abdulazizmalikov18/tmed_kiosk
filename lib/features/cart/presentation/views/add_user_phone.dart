import 'dart:io';
import 'package:tmed_kiosk/features/cart/presentation/views/user_info_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/create_user.dart';
import 'package:tmed_kiosk/features/common/navigation/presentation/navigator.dart';
import 'package:tmed_kiosk/features/common/widgets/w_container.dart';
import 'package:tmed_kiosk/features/common/widgets/w_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/accounts_list.dart';
import 'package:tmed_kiosk/features/common/widgets/w_scale_animation.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/phone_bar_scaner.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class AddUserPhone extends StatefulWidget {
  const AddUserPhone({super.key, required this.vm, required this.vmC});
  final AccountsViewModel vm;
  final CartViewModel vmC;

  @override
  State<AddUserPhone> createState() => _AddUserPhoneState();
}

class _AddUserPhoneState extends State<AddUserPhone> {
  late final vm = widget.vm;
  File? images;

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (image != null) {
      images = File(image.path);
      setState(() {});
    }
  }

  @override
  void initState() {
    context.read<AccountsBloc>().add(GetRegion());
    context
        .read<AccountsBloc>()
        .add(AccountsGet(onSucces: () {}, onError: () {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: BlocBuilder<AccountsBloc, AccountsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Container(
                width: MediaQuery.of(context).size.width / 8 * 5,
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: white.withOpacity(.1)),
                  boxShadow: wboxShadow,
                ),
                child: WTextField(
                  controller: vm.controller,
                  height: 44,
                  maxLines: 1,
                  enabled: state.selectAccount.selectAccount.name.isEmpty,
                  inputDecoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: LocaleKeys.adduser_search.tr(),
                    contentPadding: const EdgeInsets.fromLTRB(16, 10, 0, 12),
                    prefixIconConstraints: const BoxConstraints(maxWidth: 40),
                  ),
                  onChanged: (value) {
                    context.read<AccountsBloc>().add(AccountsGet(
                        search: value, onSucces: () {}, onError: () {}));
                  },
                ),
              ),
              actions: [
                if (state.selectAccount.selectAccount.name.isEmpty)
                  WScaleAnimation(
                    onTap: () {
                      Navigator.of(context).push(
                          fade(page: CreateUser(vm: vm, vmC: widget.vmC)));
                    },
                    child: WContainer(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      height: 44,
                      width: 44,
                      child: SvgPicture.asset(
                        AppIcons.userAdd,
                        colorFilter: state
                                .selectAccount.selectAccount.name.isNotEmpty
                            ? null
                            : const ColorFilter.mode(white, BlendMode.srcIn),
                      ),
                    ),
                  ),
                if (state.selectAccount.selectAccount.name.isEmpty)
                  WScaleAnimation(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ScannerPage(vm: widget.vmC)));
                    },
                    child: WContainer(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      height: 44,
                      width: 44,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(4),
                      child: SvgPicture.asset(
                        AppIcons.barCode,
                        height: 26,
                        width: 26,
                        colorFilter: const ColorFilter.mode(
                          white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 16),
              ],
            ),
            body: Builder(
              builder: (context) {
                if (state.selectAccount.selectAccount.id == 0) {
                  return AccountsList(
                    isPhone: MediaQuery.of(context).size.width <= 600,
                    vm: vm,
                  );
                } else {
                  return UserInfoView(vm: vm, isPhone: true);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
