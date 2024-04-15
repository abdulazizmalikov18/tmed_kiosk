import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/core/usecases/usecase.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/auth/data/repo/auth_set_repository_impl.dart';
import 'package:tmed_kiosk/features/auth/domain/entity/companiya_list_entity.dart';
import 'package:tmed_kiosk/features/auth/domain/repo/auth_set_repository.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';

class GetCompanyUseUseCase
    extends UseCase<GenericPagination<CompaniyaListEntity>, NoParams> {
  final AuthSetRepository repository = serviceLocator<AuthSetRepositoryImpl>();

  @override
  Future<Either<Failure, GenericPagination<CompaniyaListEntity>>> call(
          NoParams params) async =>
      await repository.getCompany();
}
