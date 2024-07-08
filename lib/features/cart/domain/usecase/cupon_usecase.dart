import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/core/usecases/usecase.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_filter.dart';
import 'package:tmed_kiosk/features/cart/data/repo/cart_repo_impl.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_model.dart';
import 'package:tmed_kiosk/features/cart/domain/repo/cart_repo.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';

class CuponUseCase extends UseCase<GenericPagination<CuponModel>, CFilter> {
  final CartRepo repository = serviceLocator<CartRepoImpl>();

  @override
  Future<Either<Failure, GenericPagination<CuponModel>>> call(
          CFilter params) async =>
      await repository.getCoupon(params);
}
