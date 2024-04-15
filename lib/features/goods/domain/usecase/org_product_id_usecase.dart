import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/core/usecases/usecase.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/goods/data/repo/goods_repo_impl.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';

class OrgProductIDUseUseCase extends UseCase<OrgProductEntity, int> {
  final GoodsRepoImpl repository = serviceLocator<GoodsRepoImpl>();

  @override
  Future<Either<Failure, OrgProductEntity>> call(int params) async =>
      await repository.getOrgProductID(params);
}
