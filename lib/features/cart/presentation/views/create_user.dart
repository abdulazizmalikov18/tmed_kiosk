import 'dart:io';

import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/add_user_iteam_phone.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/create_ph_jsh.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/user_bottom_button.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/widgets/w_container.dart';
import 'package:tmed_kiosk/features/common/widgets/w_scale_animation.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/phone_bar_scaner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key, required this.vm, required this.vmC});
  final AccountsViewModel vm;
  final CartViewModel vmC;
  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
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
    // context.read<AccountsBloc>().add(AccountsGet(onSucces: () {  }, onError: () {  }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (_) async {
            if (state.selectAccount.selectAccount.name.isNotEmpty) {
              Navigator.of(context)
                ..pop()
                ..pop();
            } else {
              Navigator.of(context).pop();
            }
          },
          child: KeyboardDismisser(
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  WScaleAnimation(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: WContainer(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 44,
                      width: 44,
                      child: SvgPicture.asset(
                        AppIcons.search,
                        height: 24,
                        width: 24,
                        colorFilter: const ColorFilter.mode(
                          greyText,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  if (state.selectAccount.selectAccount.name.isNotEmpty)
                    WScaleAnimation(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ScannerPage(vm: widget.vmC)));
                      },
                      child: WContainer(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: 44,
                        width: 44,
                        child: SvgPicture.asset(
                          AppIcons.receiptSearch,
                          height: 24,
                          width: 24,
                          colorFilter: const ColorFilter.mode(
                            greyText,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  if (state.selectAccount.selectAccount.name.isNotEmpty)
                    WScaleAnimation(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ScannerPage(vm: widget.vmC)));
                      },
                      child: WContainer(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        height: 44,
                        width: 44,
                        child: SvgPicture.asset(
                          AppIcons.timer,
                          height: 24,
                          width: 24,
                          colorFilter: const ColorFilter.mode(
                            greyText,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  WScaleAnimation(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ScannerPage(vm: widget.vmC)));
                    },
                    child: WContainer(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 44,
                      width: 44,
                      child: SvgPicture.asset(
                        AppIcons.barCode,
                        colorFilter: const ColorFilter.mode(
                          greyText,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CreatePhJsh(
                      vm: vm,
                      onTap: () {
                        context.read<AccountsBloc>().add(PostPhone(
                              phoneJshshr: vm.phone.text,
                              onSuccess: () {
                                setState(() {
                                  vm.isChek = !vm.isChek;
                                });
                              },
                              onError: (error) {
                                context.read<ShowPopUpBloc>().add(
                                      ShowPopUp(
                                        message: error,
                                        status: PopStatus.error,
                                      ),
                                    );
                              },
                            ));
                      },
                    ),
                    if (vm.isChek ||
                        state.selectAccount.selectAccount.name.isNotEmpty)
                      AddUsetIteamPhone(
                        onTap: () {
                          pickImage();
                          setState(() {});
                        },
                        images: images,
                        vm: vm,
                      ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              bottomNavigationBar:
                  vm.isChek ? UserBottomButton(vm: vm, images: images) : null,
            ),
          ),
        );
      },
    );
  }
}
