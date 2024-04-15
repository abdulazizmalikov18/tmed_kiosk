import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/core/usecases/usecase.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/cart/data/models/orders_creat_model.dart';
import 'package:tmed_kiosk/features/cart/data/repo/cart_repo_impl.dart';
import 'package:tmed_kiosk/features/cart/domain/repo/cart_repo.dart';
import 'package:tmed_kiosk/features/common/entity/orders_entity.dart';

class CreatOrderUseCase extends UseCase<OrdersEntity, OrdersCreatModel> {
  final CartRepo repository = serviceLocator<CartRepoImpl>();

  @override
  Future<Either<Failure, OrdersEntity>> call(OrdersCreatModel params) async =>
      await repository.createOrder(params);
}
