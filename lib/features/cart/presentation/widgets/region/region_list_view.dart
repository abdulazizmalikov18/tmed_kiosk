import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/region_entity.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/common/widgets/w_scale_animation.dart';

class RegionListView extends StatefulWidget {
  const RegionListView({
    super.key,
    required this.regions,
    required this.controller,
    required this.vm,
    required this.index,
    required this.isLoading,
  });
  final List<RegionEntity> regions;
  final PageController controller;
  final AccountsViewModel vm;
  final int index;
  final bool isLoading;

  @override
  State<RegionListView> createState() => _RegionListViewState();
}

class _RegionListViewState extends State<RegionListView> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            shrinkWrap: true,
            itemCount: widget.regions.length,
            itemBuilder: (context, index) => WScaleAnimation(
              onTap: () {
                if (widget.regions[index].isParent) {
                  if (widget.controller.hasClients) {
                    widget.controller.animateToPage(
                      widget.index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                  widget.vm.selectPag(
                    context,
                    widget.index,
                    widget.regions[index].name,
                    widget.regions[index].id,
                  );
                } else {
                  Navigator.pop(context, widget.regions[index]);
                  widget.vm.selectPag(context, 0, "", 0);
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.regions[index].name),
                    if (widget.regions[index].isParent)
                      AppIcons.arrowRight.svg(color: white),
                  ],
                ),
              ),
            ),
          );
  }
}
