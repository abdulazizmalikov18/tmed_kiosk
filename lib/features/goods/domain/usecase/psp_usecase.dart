import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/core/usecases/usecase.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';
import 'package:tmed_kiosk/features/goods/data/repo/goods_repo_impl.dart';
import 'package:tmed_kiosk/features/main/domain/entity/product_specia.dart';

class PspUseUseCase
    extends UseCase<GenericPagination<ProductSpecialEntity>, int> {
  final GoodsRepoImpl repository = serviceLocator<GoodsRepoImpl>();

  @override
  Future<Either<Failure, GenericPagination<ProductSpecialEntity>>> call(
          int params) async =>
      await repository.getPSp(params);
}
