import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/common/models/popular_category_filter.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';

import 'package:tmed_kiosk/features/specialists/data/model/specil_filter.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/day_id.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/spec_cat_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/specialist_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/today_time_table_entity.dart';

abstract class SpecialistsRepository {
  Future<Either<Failure, GenericPagination<SpecialistsEntity>>> getSpecialists(
      SpecialFilter param);
  Future<Either<Failure, GenericPagination<SpecCatEntity>>> getSpecialistCats(
      Filter param);

  Future<Either<Failure, GenericPagination<TodayTimetableEntity>>> getTimetable(
      int id);
  Future<Either<Failure, TodayTimetableEntity>> getTimetableDay(DayId param);
}
