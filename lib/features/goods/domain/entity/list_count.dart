import 'package:tmed_kiosk/features/main/domain/entity/product_specia.dart';

class ListCount {
  int id;
  int count;
  int price;
  int discount;
  int allPrice;
  ProductSpecialEntity? psp;
  DateTime? dateTime;
  int discountPrice;
  List<int>? surchargeIds;
  int? supplies;
  int? selectIndex;
  int? dataIndex;
  bool isSelection;
  int priceIndex;
  int cuponPrice;
  int pricePercent;
  ListCount({
    this.id = 0,
    this.count = 0,
    this.price = 0,
    this.discount = 0,
    this.allPrice = 0,
    this.psp,
    this.dateTime,
    this.discountPrice = 0,
    this.surchargeIds,
    this.supplies,
    this.selectIndex,
    this.dataIndex,
    this.isSelection = false,
    this.priceIndex = 0,
    this.cuponPrice = 0,
    this.pricePercent = 0,
  });
}
