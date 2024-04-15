import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/core/usecases/usecase.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';
import 'package:tmed_kiosk/features/goods/data/model/goods_query_parameters.dart';
import 'package:tmed_kiosk/features/goods/data/model/org_product_model.dart';
import 'package:tmed_kiosk/features/goods/data/repo/goods_repo_impl.dart';

class OrgProductUseUseCase
    extends UseCase<GenericPagination<OrgProductModel>, GoodsQueryParam> {
  final GoodsRepoImpl repository = serviceLocator<GoodsRepoImpl>();

  @override
  Future<Either<Failure, GenericPagination<OrgProductModel>>> call(
          GoodsQueryParam params) async =>
      await repository.getOrgProduct(params);
}
