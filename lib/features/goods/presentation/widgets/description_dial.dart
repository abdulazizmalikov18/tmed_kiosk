import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/presentation/widgets/dialog_goods_psp.dart';

class DescriptionDialog extends StatelessWidget {
  const DescriptionDialog(
      {super.key, required this.product, required this.bloc});
  final OrgProductEntity product;
  final GoodsBloc bloc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (product.product.images.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 16),
                  itemCount: product.product.images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      color: whiteGrey,
                      height: 100,
                      width: 100,
                      child: Image.network(
                        product.product.images[index].file,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, url, error) => const SizedBox(),
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 12),
            Text(
              product.product.name,
              style: AppTheme.bodyMedium.copyWith(fontSize: 20),
            ),
            const Divider(color: lightBlue),
            const SizedBox(height: 12),
            if (product.productFeatures.isNotEmpty)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Parametr:",
                    style: AppTheme.bodyLarge,
                  ),
                  ...List.generate(
                    product.productFeatures.length,
                    (index) => Row(
                      children: [
                        Text(
                          "${product.productFeatures[index].feature.name}: ",
                          style: AppTheme.labelSmall,
                        ),
                        ...List.generate(
                          product.productFeatures[index].preparedValue.length,
                          (index) => Text(
                            product.productFeatures[index].preparedValue[index]
                                .value,
                            style: AppTheme.titleLarge,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 12),
            const Text(
              "Tafsif: ",
              style: AppTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: AppTheme.labelSmall,
            ),
            if (product.product.type.name == "product")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      "Mas’ul xodimlar:",
                      style: AppTheme.bodyLarge,
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        "In stock: ",
                        style: AppTheme.labelSmall,
                      ),
                      Text(
                        "${product.remains}",
                        style: AppTheme.titleLarge,
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Offer place: ",
                      style: AppTheme.labelSmall,
                      children: [
                        TextSpan(
                          text: product.placeDesc,
                          style: AppTheme.titleLarge,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              )
            else
              DialogGoodsPsp(bloc: bloc)
          ],
        ),
      ),
    );
  }
}
