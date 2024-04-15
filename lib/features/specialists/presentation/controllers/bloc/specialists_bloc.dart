import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/features/common/models/popular_category_filter.dart';
import 'package:tmed_kiosk/features/specialists/data/model/specil_filter.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/spec_cat_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/specialist_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/usecase/special_cat.dart';
import 'package:tmed_kiosk/features/specialists/domain/usecase/specialists_usecase.dart';

part 'specialists_event.dart';
part 'specialists_state.dart';

class SpecialistsBloc extends Bloc<SpecialistsEvent, SpecialistsState> {
  SpecialistsUseUseCase useCase = SpecialistsUseUseCase();
  SpeciaCatUseUseCase specCat = SpeciaCatUseUseCase();
  SpecialistsBloc() : super(const SpecialistsState()) {
    on<GetSpecialists>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final SpecialFilter param = SpecialFilter(
        specCat: event.index,
        search: event.search,
        canel: event.canel,
      );
      final result = await useCase.call(param);
      if (result.isRight) {
        emit(state.copyWith(
          specialistsList: result.right.results,
          count: result.right.count,
          search: event.search,
          status: FormzSubmissionStatus.success,
          specCat: event.index,
        ));
        if (event.onSucces != null) {
          event.onSucces!(result.right.results);
        }
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });
    on<GetMoreSpecialists>((event, emit) async {
      SpecialFilter param = SpecialFilter(
        offset: state.specialistsList.length,
        search: state.search.isEmpty ? null : state.search,
      );

      final result = await useCase.call(param);
      if (result.isRight) {
        emit(state.copyWith(
          specialistsList: [...state.specialistsList, ...result.right.results],
          count: result.right.count,
          statusP: FormzSubmissionStatus.success,
        ));
      } else {
        emit(state.copyWith(statusP: FormzSubmissionStatus.failure));
      }
    });

    on<GetSpeciaCats>((event, emit) async {
      if (!event.isMore) {
        emit(state.copyWith(statusP: FormzSubmissionStatus.inProgress));
      }
      final filter = Filter(
        offset: event.isMore ? state.specialCatrs.length : 0,
      );
      final results = await specCat.call(filter);
      if (results.isRight) {
        emit(state.copyWith(
          specialCatrs: !event.isMore
              ? results.right.results
              : [...state.specialCatrs, ...results.right.results],
          statusP: FormzSubmissionStatus.success,
          catCount: results.right.count,
        ));
      } else {
        emit(state.copyWith(statusP: FormzSubmissionStatus.failure));
      }
    });

    on<SelectionIndex>(
      (event, emit) => emit(state.copyWith(selection: event.index)),
    );
  }
}
