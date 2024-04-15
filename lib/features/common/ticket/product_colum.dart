import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/common/entity/order_product_entity.dart';
import 'package:tmed_kiosk/features/common/ticket/row_title.dart';
import 'package:pdf/widgets.dart' as pw;

class ProductColum extends pw.StatelessWidget {
  ProductColum({required this.product});
  final OrderProductEntity product;
  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        RowTitle(
          title: product.name,
          subtitle:
              "${product.qty} ${MyFunctions.getFormatCost(product.fullCost.toString())}",
        ),
        RowTitle(
          title: "QQS",
          subtitle: "QQS yo'q",
        ),
      ],
    );
  }
}
