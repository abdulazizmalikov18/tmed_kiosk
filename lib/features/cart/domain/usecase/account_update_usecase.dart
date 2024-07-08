import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/core/usecases/usecase.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/cart/data/models/update_account.dart';
import 'package:tmed_kiosk/features/cart/data/repo/cart_repo_impl.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/accounts_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/repo/cart_repo.dart';

class AccountUpdateUseCase extends UseCase<AccountsEntity, UpdateAccount> {
  final CartRepo repository = serviceLocator<CartRepoImpl>();

  @override
  Future<Either<Failure, AccountsEntity>> call(UpdateAccount params) async =>
      await repository.accountUpdate(params);
}
