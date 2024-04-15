import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/core/usecases/usecase.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/category/data/model/catigory_filter_model.dart';
import 'package:tmed_kiosk/features/category/data/repo/category_repo_impl.dart';
import 'package:tmed_kiosk/features/category/domain/entity/catigory_entity.dart';
import 'package:tmed_kiosk/features/category/domain/repo/category_repo.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';

class CategorysUseUseCase
    extends UseCase<GenericPagination<CategoryEntity>, CatigoryFilter> {
  final CategoryRepository repository =
      serviceLocator<CategoryRepositoryIMPl>();

  @override
  Future<Either<Failure, GenericPagination<CategoryEntity>>> call(
          CatigoryFilter params) async =>
      await repository.categoryList(params);
}
