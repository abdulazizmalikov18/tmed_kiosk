import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/category/data/model/catigory_filter_model.dart';
import 'package:tmed_kiosk/features/category/domain/entity/catigory_entity.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';

abstract class CategoryRepository {
  Future<Either<Failure, GenericPagination<CategoryEntity>>> categoryList(
      CatigoryFilter param);
}
