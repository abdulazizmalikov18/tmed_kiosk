import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/features/goods/data/model/goods_query_parameters.dart';
import 'package:tmed_kiosk/features/goods/data/model/org_product_model.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/supplies_entity.dart';
import 'package:tmed_kiosk/features/goods/domain/usecase/org_product_id_usecase.dart';
import 'package:tmed_kiosk/features/goods/domain/usecase/org_product_usecase.dart';
import 'package:tmed_kiosk/features/goods/domain/usecase/product_barcode_usecase.dart';
import 'package:tmed_kiosk/features/goods/domain/usecase/psp_usecase.dart';
import 'package:tmed_kiosk/features/goods/domain/usecase/supplies_usecase.dart';
import 'package:tmed_kiosk/features/main/domain/entity/product_specia.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/day_id.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/today_time_table_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/usecase/time_day_usecase.dart';
import 'package:tmed_kiosk/features/specialists/domain/usecase/timetable_usecase.dart';

part 'goods_event.dart';
part 'goods_state.dart';

class GoodsBloc extends Bloc<GoodsEvent, GoodsState> {
  OrgProductUseUseCase useCase = OrgProductUseUseCase();
  PspUseUseCase pspCase = PspUseUseCase();
  SuppliesUseUseCase supplies = SuppliesUseUseCase();
  TimetableUseUseCase timeCase = TimetableUseUseCase();
  TimeDayUseUseCase timeDay = TimeDayUseUseCase();
  OrgProductIDUseUseCase productId = OrgProductIDUseUseCase();
  ProductBarCodeUseCase prBarCodeUse = ProductBarCodeUseCase();
  GoodsBloc() : super(const GoodsState()) {
    on<GetOrgProduct>((event, emit) async {
      String? orde;
      if (event.ordering == 1) {
        orde = 'product__name';
      } else if (event.ordering == 2) {
        orde = 'productprice__value';
      } else {
        orde = "id";
      }
      GoodsQueryParam param = GoodsQueryParam(
        search: event.search,
        isOffline: true,
      );
      if (event.isLoading) {
        emit(state.copyWith(statusProduct: FormzSubmissionStatus.inProgress));
      }
      final result = await useCase.call(param);
      if (result.isRight) {
        emit(state.copyWith(
          orgProduct: result.right.results,
          count: result.right.count,
          search: event.search,
          statusProduct: FormzSubmissionStatus.success,
        ));
        if (event.search == null) {
          add(GetProductApi(length: orde));
        }
      } else {
        emit(state.copyWith(statusProduct: FormzSubmissionStatus.failure));
      }
    });

    on<GetProductApi>((event, emit) async {
      GoodsQueryParam param = GoodsQueryParam();
      final resultt = await useCase.call(param);
      if (resultt.isRight) {
        emit(state.copyWith(
          orgProduct: resultt.right.results,
          count: resultt.right.count,
          statusProduct: FormzSubmissionStatus.success,
        ));
      } else {
        emit(state.copyWith(statusProduct: FormzSubmissionStatus.failure));
      }
    });

    on<GetMoreOrgProduct>((event, emit) async {
      GoodsQueryParam param = GoodsQueryParam(
        offset: state.orgProduct.length,
        search: state.search.isEmpty ? null : state.search,
      );
      final result = await useCase.call(param);
      if (result.isRight) {
        emit(state.copyWith(
          orgProduct: [...state.orgProduct, ...result.right.results],
          count: result.right.count,
          statusProduct: FormzSubmissionStatus.success,
        ));
      } else {
        emit(state.copyWith(statusProduct: FormzSubmissionStatus.failure));
      }
    });

    on<PrBarCode>((event, emit) async {
      emit(state.copyWith(status3: FormzSubmissionStatus.inProgress));
      final result = await prBarCodeUse.call(event.barcode);
      if (result.isRight) {
        event.onSucces(result.right);
        emit(state.copyWith(status3: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(status3: FormzSubmissionStatus.failure));
        event.onError((result.left as ServerFailure).errorMessage);
      }
    });

    on<GetOrgProductID>((event, emit) async {
      emit(state.copyWith(status3: FormzSubmissionStatus.inProgress));
      final result = await productId.call(event.id);

      if (result.isRight) {
        emit(state.copyWith(status3: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(status3: FormzSubmissionStatus.failure));
      }
    });

    on<GetPsp>((event, emit) async {
      emit(state.copyWith(status2: FormzSubmissionStatus.inProgress));
      final result = await pspCase.call(event.id);
      if (result.isRight) {
        emit(state.copyWith(
          psp: result.right.results,
          status2: FormzSubmissionStatus.success,
        ));
      } else {
        emit(state.copyWith(status2: FormzSubmissionStatus.failure));
      }
    });

    on<GetTimeTable>((event, emit) async {
      emit(state.copyWith(status3: FormzSubmissionStatus.inProgress));
      final result = await timeCase.call(event.id);
      if (result.isRight) {
        emit(state.copyWith(
          timetable: result.right.results,
          status3: FormzSubmissionStatus.success,
        ));
        add(GetTimeDay(event.id, DateTime.now()));
      } else {
        emit(state.copyWith(status3: FormzSubmissionStatus.failure));
      }
    });

    on<GetTimeDay>((event, emit) async {
      emit(state.copyWith(status3: FormzSubmissionStatus.inProgress));
      final day = DayId(
        id: event.id,
        day: "${event.day.year}-${event.day.month}-${event.day.day}",
      );
      final result = await timeDay.call(day);
      if (result.isRight) {
        emit(state.copyWith(
          timeDay: result.right,
          status3: FormzSubmissionStatus.success,
        ));
      } else {
        emit(state.copyWith(status3: FormzSubmissionStatus.failure));
      }
    });

    on<GetSupplies>((event, emit) async {
      Map<int, List<SuppliesEntity>> map = {};
      map.addAll(state.suppliesSave);
      if (!map.containsKey(event.id)) {
        emit(state.copyWith(status2: FormzSubmissionStatus.inProgress));
        final result = await supplies.call(event.id);
        if (result.isRight) {
          map[event.id] = result.right.results;
          emit(state.copyWith(
            supplies: result.right.results,
            suppliesSave: map,
            status2: FormzSubmissionStatus.success,
          ));
        } else {
          emit(state.copyWith(status2: FormzSubmissionStatus.failure));
        }
      } else {
        final supplies = map[event.id];
        emit(state.copyWith(
          supplies: supplies,
          status2: FormzSubmissionStatus.success,
        ));
      }
    });

    on<GetCategoryPro>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      GoodsQueryParam param = GoodsQueryParam(
        group: event.group,
        search: event.search,
      );
      final result = await useCase.call(param);
      if (result.isRight) {
        emit(state.copyWith(
          catigoryPro: result.right.results,
          countCategory: result.right.count,
          status: FormzSubmissionStatus.success,
        ));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });

    on<GetMoreProductCategory>((event, emit) async {
      GoodsQueryParam param = GoodsQueryParam(
        offset: state.catigoryPro.length,
        search: state.search.isEmpty ? null : state.search,
        group: event.group,
      );
      final result = await useCase.call(param);
      if (result.isRight) {
        emit(state.copyWith(
          catigoryPro: [...state.catigoryPro, ...result.right.results],
          countCategory: result.right.count,
          status: FormzSubmissionStatus.success,
        ));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });

    on<GetSpecialistPro>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      GoodsQueryParam param = GoodsQueryParam(specialist: event.specialist);
      final result = await useCase.call(param);
      if (result.isRight) {
        emit(state.copyWith(
          specialistPro: result.right.results,
          status: FormzSubmissionStatus.success,
        ));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });
  }
}
