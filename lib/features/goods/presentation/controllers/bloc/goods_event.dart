part of 'goods_bloc.dart';

abstract class GoodsEvent {}

class GetOrgProduct extends GoodsEvent {
  final String? search;
  final int ordering;
  final bool isOfline;

  final bool isLoading;

  GetOrgProduct({
    this.search,
    this.ordering = 0,
    this.isOfline = false,
    this.isLoading = true,
  });
}

class GetOrgProductID extends GoodsEvent {
  final int id;

  GetOrgProductID({this.id = 0});
}

class GetProductApi extends GoodsEvent {
  final String length;

  GetProductApi({required this.length});
}

class GetPsp extends GoodsEvent {
  final int id;

  GetPsp(this.id);
}

class GetTimeTable extends GoodsEvent {
  final int id;

  GetTimeTable(this.id);
}

class GetTimeDay extends GoodsEvent {
  final int id;
  final DateTime day;

  GetTimeDay(this.id, this.day);
}

class GetSupplies extends GoodsEvent {
  final int id;

  GetSupplies(this.id);
}

class GetMoreOrgProduct extends GoodsEvent {}

class GetCategoryPro extends GoodsEvent {
  final int group;
  final String? search;

  GetCategoryPro(this.group, {this.search});
}

class GetMoreProductCategory extends GoodsEvent {
  final int group;
  GetMoreProductCategory(this.group);
}

class GetSpecialistPro extends GoodsEvent {
  final int specialist;

  GetSpecialistPro(this.specialist);
}

class PrBarCode extends GoodsEvent {
  final String barcode;
  final Function(OrgProductEntity) onSucces;
  final Function(String) onError;

  PrBarCode(this.barcode, {required this.onSucces, required this.onError});
}
