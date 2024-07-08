import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/core/usecases/usecase.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/cart/data/repo/cart_repo_impl.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_model.dart';
import 'package:tmed_kiosk/features/cart/domain/repo/cart_repo.dart';

class CuponIdUseCase extends UseCase<CuponModel, int> {
  final CartRepo repository = serviceLocator<CartRepoImpl>();

  @override
  Future<Either<Failure, CuponModel>> call(int params) async =>
      await repository.getCouponID(params);
}
