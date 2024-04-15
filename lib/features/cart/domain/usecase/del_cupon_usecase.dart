import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/core/usecases/usecase.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_selection.dart';
import 'package:tmed_kiosk/features/cart/data/repo/cart_repo_impl.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/cupon_res_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/repo/cart_repo.dart';

class DelCuponUseCase extends UseCase<CuponResEntity, CuSel> {
  final CartRepo repository = serviceLocator<CartRepoImpl>();

  @override
  Future<Either<Failure, CuponResEntity>> call(CuSel params) async =>
      await repository.delateCupon(params);
}
