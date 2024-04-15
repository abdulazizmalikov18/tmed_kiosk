import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/core/usecases/usecase.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';
import 'package:tmed_kiosk/features/specialists/data/repo/specialists_repo_impl.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/today_time_table_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/repo/specialists_repo.dart';

class TimetableUseUseCase
    extends UseCase<GenericPagination<TodayTimetableEntity>, int> {
  final SpecialistsRepository repository =
      serviceLocator<SpecialistsRepositoryImpl>();

  @override
  Future<Either<Failure, GenericPagination<TodayTimetableEntity>>> call(
          int params) async =>
      await repository.getTimetable(params);
}
