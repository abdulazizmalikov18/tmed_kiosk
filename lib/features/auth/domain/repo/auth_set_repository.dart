import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/auth/domain/entity/companiya_list_entity.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';

abstract class AuthSetRepository {
  Future<Either<Failure, GenericPagination<CompaniyaListEntity>>> getCompany();
}
