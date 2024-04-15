import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/profession/profession_list.dart';
import 'package:tmed_kiosk/features/common/widgets/dialog_title.dart';
import 'package:tmed_kiosk/features/common/widgets/w_textfield.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class ProfessionDialog extends StatefulWidget {
  const ProfessionDialog({super.key, required this.vm});
  final AccountsViewModel vm;

  @override
  State<ProfessionDialog> createState() => _ProfessionDialogState();
}

class _ProfessionDialogState extends State<ProfessionDialog> {
  final PageController controller = PageController(initialPage: 0);
  @override
  void initState() {
    context.read<AccountsBloc>().add(GetProfession());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        return SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DialogTitle(title: "Select your profession"),
              const SizedBox(height: 8),
              WTextField(
                onChanged: (value) {
                  context
                      .read<AccountsBloc>()
                      .add(GetProfession(search: value));
                },
                hintText: LocaleKeys.offerpageSearch.tr(),
                suffix: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: SvgPicture.asset(AppIcons.search),
                ),
              ),
              const SizedBox(height: 16),
              if (widget.vm.professionList.isNotEmpty)
                InkWell(
                  onTap: () {
                    if (controller.hasClients) {
                      controller.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                    widget.vm.selectPagProffesion(context, 0, "", 0);
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
                    ProfessionListView(
                      profession: state.profession,
                      controller: controller,
                      vm: widget.vm,
                      index: 1,
                      isLoading: state.statusd.isInProgress,
                    ),
                    ProfessionListView(
                      profession: state.profession2,
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
