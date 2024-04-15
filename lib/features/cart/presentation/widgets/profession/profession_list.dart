import 'package:tmed_kiosk/features/common/repo/log_service.dart';
import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/profession_entity.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/common/widgets/w_scale_animation.dart';

class ProfessionListView extends StatefulWidget {
  const ProfessionListView({
    super.key,
    required this.profession,
    required this.controller,
    required this.vm,
    required this.index,
    required this.isLoading,
  });
  final List<ProfessionEntity> profession;
  final PageController controller;
  final AccountsViewModel vm;
  final int index;
  final bool isLoading;

  @override
  State<ProfessionListView> createState() => _ProfessionListViewState();
}

class _ProfessionListViewState extends State<ProfessionListView> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            shrinkWrap: true,
            itemCount: widget.profession.length,
            itemBuilder: (context, index) => WScaleAnimation(
              onTap: () {
                if (widget.profession[index].isParent) {
                  Log.w(widget.profession[index].isParent);
                  if (widget.controller.hasClients) {
                    widget.controller.animateToPage(
                      widget.index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                  widget.vm.selectPagProffesion(
                    context,
                    widget.index,
                    widget.profession[index].name,
                    widget.profession[index].id,
                  );
                } else {
                  Navigator.pop(context, widget.profession[index]);
                  widget.vm.selectPagProffesion(context, 0, "", 0);
                }

                setState(() {});
              },
              child: Container(
                height: 48,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: greyText))),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 12),
                      width: 40,
                      child: widget.profession[index].image.isEmpty
                          ? const SizedBox()
                          : Image.network(
                              widget.profession[index].image,
                              errorBuilder: (context, error, stackTrace) =>
                                  const SizedBox(),
                            ),
                    ),
                    Expanded(child: Text(widget.profession[index].name)),
                    if (widget.profession[index].isParent)
                      AppIcons.arrowRight.svg(color: white),
                  ],
                ),
              ),
            ),
          );
  }
}
