import 'package:easy_localization/easy_localization.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/constants/images.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/category/presentation/controllers/bloc/category_bloc.dart';
import 'package:tmed_kiosk/features/category/presentation/views/selection_catigory_view.dart';
import 'package:tmed_kiosk/features/category/presentation/widgets/category_shimmer.dart';
import 'package:tmed_kiosk/features/common/navigation/presentation/navigator.dart';
import 'package:tmed_kiosk/features/common/pagination/presentation/paginator.dart';
import 'package:tmed_kiosk/features/common/widgets/w_appbar.dart';
import 'package:tmed_kiosk/features/common/widgets/w_scale_animation.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/no_data_cart.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyNavigatorBloc, MyNavigatorState>(
      builder: (context, state) {
        return Scaffold(
          appBar: WAppBar(
            onTapRow: () {
              context.read<MyNavigatorBloc>().add(IsImageC(!state.isImageC));
            },
            rowIcon: state.isImageC,
            onChanged: (value) {
              context.read<CategoryBloc>().add(GetCategory(search: value));
            },
          ),
          body: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, stateC) {
              if (stateC.status.isInProgress) {
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: state.isImageC ? 308 : 76,
                    maxCrossAxisExtent: state.openCart ? 700 : 480,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) => const CategoryShimmer(),
                );
              } else {
                if (stateC.categoryList.isEmpty) {
                  return const Center(
                    child: NoDataCart(
                      image: AppIcons.noData,
                      title: 'Nothing have',
                      isButton: true,
                    ),
                  );
                } else {
                  return Paginator(
                    padding: const EdgeInsets.all(16),
                    itemCount: stateC.categoryList.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: state.isImageC ? 308 : 76,
                      maxCrossAxisExtent: state.openCart ? 700 : 480,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    loadingWidget: const CategoryShimmer(),
                    itemBuilder: (context, index) => WScaleAnimation(
                      onTap: () {
                        context
                            .read<GoodsBloc>()
                            .add(GetCategoryPro(stateC.categoryList[index].id));
                        Navigator.of(context).push(fade(
                            page: SelectionCatigoryView(
                                id: stateC.categoryList[index].id)));
                      },
                      child: Container(
                        width: 440,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: white,
                          boxShadow: wboxShadow,
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (state.isImageC)
                              AnimatedContainer(
                                height: state.isImageC ? 224 : 0,
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: greyText,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        stateC.categoryList[index].image),
                                    onError: (exception, stackTrace) =>
                                        Image.asset(AppImages.logo),
                                  ),
                                ),
                                duration: const Duration(microseconds: 300),
                              ),
                            Text(
                              stateC.categoryList[index].name,
                              style: AppTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            Text(
                              '${LocaleKeys.offer_detail_quantity.tr()}: ${stateC.categoryList[index].productNumbers}',
                              style: AppTheme.labelSmall,
                            )
                          ],
                        ),
                      ),
                    ),
                    errorWidget: const SizedBox(),
                    fetchMoreFunction: () {},
                    hasMoreToFetch: stateC.count > stateC.categoryList.length,
                    paginatorStatus: stateC.statusP,
                  );
                }
              }
            },
          ),
        );
      },
    );
  }
}
