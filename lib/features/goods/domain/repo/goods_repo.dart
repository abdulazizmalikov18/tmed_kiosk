import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';
import 'package:tmed_kiosk/features/goods/data/model/goods_query_parameters.dart';
import 'package:tmed_kiosk/features/goods/data/model/org_product_model.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/supplies_entity.dart';
import 'package:tmed_kiosk/features/main/domain/entity/product_specia.dart';

abstract class GoodsRepo {
  Future<Either<Failure, GenericPagination<OrgProductModel>>> getOrgProduct(
      GoodsQueryParam param);
  Future<Either<Failure, OrgProductEntity>> getProductBarCode(String param);
  Future<Either<Failure, OrgProductEntity>> getOrgProductID(int param);
  Future<Either<Failure, List<OrgProductEntity>>> getOrgProductIDList(
      List<int> param);
  Future<Either<Failure, GenericPagination<SuppliesEntity>>> getSupplies(
      int id);
  Future<Either<Failure, GenericPagination<ProductSpecialEntity>>> getPSp(
      int id);
}
