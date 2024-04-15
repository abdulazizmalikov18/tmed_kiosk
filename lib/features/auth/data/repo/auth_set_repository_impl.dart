import 'package:dio/dio.dart';
import 'package:tmed_kiosk/core/exceptions/exceptions.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/utils/either.dart';
import 'package:tmed_kiosk/features/auth/data/datasources/auth_data_source.dart';
import 'package:tmed_kiosk/features/auth/domain/entity/companiya_list_entity.dart';
import 'package:tmed_kiosk/features/auth/domain/repo/auth_set_repository.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';

class AuthSetRepositoryImpl extends AuthSetRepository {
  final AuthDataSourcheImpl dataSource;

  AuthSetRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, GenericPagination<CompaniyaListEntity>>>
      getCompany() async {
    try {
      final result = await dataSource.getCompany();
      return Right(result);
    } on DioException {
      return Left(DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(
          errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }
}
