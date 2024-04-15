import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/region/region_list_view.dart';
import 'package:tmed_kiosk/features/common/widgets/dialog_title.dart';
import 'package:tmed_kiosk/features/common/widgets/w_scale_animation.dart';
import 'package:tmed_kiosk/features/common/widgets/w_textfield.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class RegionDialog extends StatefulWidget {
  const RegionDialog({super.key, required this.vm});
  final AccountsViewModel vm;

  @override
  State<RegionDialog> createState() => _RegionDialogState();
}

class _RegionDialogState extends State<RegionDialog> {
  final PageController controller = PageController(initialPage: 0);
  @override
  void initState() {
    context.read<AccountsBloc>().add(GetRegion());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        return SizedBox(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const DialogTitle(title: "Vazifa jarayoni"),
              const SizedBox(height: 8),
              WTextField(
                onChanged: (value) {
                  context.read<AccountsBloc>().add(GetRegion(search: value));
                },
                hintText: LocaleKeys.offerpageSearch.tr(),
                suffix: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: SvgPicture.asset(AppIcons.search),
                ),
              ),
              const SizedBox(height: 24),
              if (widget.vm.pageInTitle.isNotEmpty)
                WScaleAnimation(
                  onTap: () {
                    if (widget.vm.pageInTitle.length > 1) {
                      if (controller.hasClients) {
                        controller.animateToPage(
                          controller.page!.toInt() - 1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                      widget.vm.selectPag(
                        context,
                        controller.page!.toInt() - 1,
                        "",
                        widget.vm.pageInTitle[controller.page?.toInt() ?? 0].id,
                      );
                    } else if (controller.hasClients) {
                      controller.animateToPage(
                        controller.page!.toInt() - 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                      widget.vm.selectPag(context, 0, "", 0);
                    }
                    setState(() {});
                  },
                  child: Container(
                    height: 24,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: AppIcons.arrowLeft.svg(color: white),
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: greyText),
                ),
                height: 460,
                child: PageView(
                  controller: controller,
                  children: [
                    RegionListView(
                      regions: state.regions,
                      controller: controller,
                      vm: widget.vm,
                      index: 1,
                      isLoading: state.statusd.isInProgress,
                    ),
                    RegionListView(
                      regions: state.regions1,
                      controller: controller,
                      vm: widget.vm,
                      index: 2,
                      isLoading: state.statusd.isInProgress,
                    ),
                    RegionListView(
                      regions: state.regions2,
                      controller: controller,
                      vm: widget.vm,
                      index: 2,
                      isLoading: state.statusd.isInProgress,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
