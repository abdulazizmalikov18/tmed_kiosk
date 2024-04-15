// import 'package:tmed_kiosk/core/exceptions/failures.dart';
// import 'package:tmed_kiosk/core/singletons/service_locator.dart';
// import 'package:tmed_kiosk/core/usecases/usecase.dart';
// import 'package:tmed_kiosk/core/utils/either.dart';
// import 'package:tmed_kiosk/features/cart/data/repo/cart_repo_impl.dart';
// import 'package:tmed_kiosk/features/cart/domain/entity/process_work_entity.dart';
// import 'package:tmed_kiosk/features/cart/domain/repo/cart_repo.dart';
// import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';

// class ProcessWorkUseCase
//     extends UseCase<GenericPagination<ProcessWorkEntity>, NoParams> {
//   final CartRepo repository = serviceLocator<CartRepoImpl>();

//   @override
//   Future<Either<Failure, GenericPagination<ProcessWorkEntity>>> call(
//           NoParams params) async =>
//       await repository.prcessWork();
// }
