import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/card_list_iteam.dart';
import 'package:tmed_kiosk/features/category/presentation/controllers/bloc/category_bloc.dart';
import 'package:tmed_kiosk/features/common/navigation/routs_contact.dart';
import 'package:tmed_kiosk/features/common/pagination/presentation/paginator_list.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tmed_kiosk/features/goods/presentation/views/goods_view.dart';

class BottomCategoryList extends StatefulWidget {
  const BottomCategoryList({super.key, this.isPhone = false});

  final bool isPhone;

  @override
  State<BottomCategoryList> createState() => _BottomCategoryListState();
}

class _BottomCategoryListState extends State<BottomCategoryList> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state.status.isSuccess) {
            if (widget.isPhone) {
              return PaginatorList(
                controller: controller,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemCount: state.category.length,
                scrollDirection: Axis.vertical,
                padding: widget.isPhone ? const EdgeInsets.fromLTRB(16, 0, 16, 8) : null,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    context.read<CategoryBloc>().add(SelectionIndex(index: state.category[index].id ?? 0));
                    if (state.category[index].id != 0) {
                      context.read<GoodsBloc>().add(GetCategoryPro(state.category[index].id!));
                      context.go(RoutsContact.goods);
                    } else {
                      context.read<GoodsBloc>().add(GetOrgProduct(isOfline: true));
                      context.go(RoutsContact.goods);
                    }
                  },
                  child: Container(
                    height: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.isPhone ? 8 : 32),
                      border: Border.all(color: context.color.white.withOpacity(.1)),
                      color: state.selIndex == state.category[index].id ? blue : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      state.category[index].name!,
                      style: AppTheme.labelSmall.copyWith(
                        color: state.selIndex == state.category[index].id ? white : context.color.white.withOpacity(.5),
                      ),
                    ),
                  ),
                ),
                paginatorStatus: state.status,
                fetchMoreFunction: () {},
                hasMoreToFetch: state.count > state.category.length,
                errorWidget: const SizedBox(),
              );
            } else {
              return PaginatorList(
                controller: controller,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemCount: state.category.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    context.read<CategoryBloc>().add(SelectionIndex(index: state.category[index].id ?? 0));
                    if (state.category[index].id != 0) {
                      context.read<GoodsBloc>().add(GetCategoryPro(state.category[index].id!));
                      context.go(RoutsContact.goods);
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GoodsView(),));
                    } else {
                      context.read<GoodsBloc>().add(GetOrgProduct(isOfline: true));
                      context.go(RoutsContact.goods);
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GoodsView(),));
                    }
                  },
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: context.color.white.withOpacity(.1)),
                      color: state.selIndex == state.category[index].id ? blue : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      state.category[index].name!,
                      style: AppTheme.displayLarge.copyWith(
                        color: state.selIndex == state.category[index].id ? white : context.color.white.withOpacity(.5),
                      ),
                    ),
                  ),
                ),
                paginatorStatus: state.status,
                fetchMoreFunction: () {},
                hasMoreToFetch: state.count > state.category.length,
                errorWidget: const SizedBox(),
              );
            }
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              itemCount: 25,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => SizedBox(
                height: 100,
                child: Shimmer.fromColors(
                  baseColor: blue.withOpacity(0.13),
                  highlightColor: blue.withOpacity(0.01),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: blue,
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}