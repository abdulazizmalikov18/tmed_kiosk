import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/features/category/data/model/catigory_filter_model.dart';
import 'package:tmed_kiosk/features/category/data/model/catigory_list_model.dart';
import 'package:tmed_kiosk/features/category/domain/entity/catigory_entity.dart';
import 'package:tmed_kiosk/features/category/domain/usecase/category_list_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategorysUseUseCase useCase = CategorysUseUseCase();
  CategoryBloc() : super(const CategoryState()) {
    on<GetCategory>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      CatigoryFilter param =
          CatigoryFilter(search: event.search, isOfline: event.isOfline);
      final result = await useCase.call(param);
      if (result.isRight) {
        List<CatigoryList> category = List.generate(
          result.right.results.length,
          (index) => CatigoryList(
            id: result.right.results[index].id,
            name: result.right.results[index].name,
          ),
        );
        category.insert(0, CatigoryList(name: "ALL"));
        emit(state.copyWith(
          categoryList: result.right.results,
          category: category,
          search: event.search,
          count: result.right.count,
          status: FormzSubmissionStatus.success,
        ));
        add(GetCategoryApi(limit: result.right.results.length));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });

    on<GetCategoryApi>((event, emit) async {
      CatigoryFilter param = CatigoryFilter(limit: event.limit);
      final result = await useCase.call(param);
      if (result.isRight) {
        List<CatigoryList> category = List.generate(
          result.right.results.length,
          (index) => CatigoryList(
            id: result.right.results[index].id,
            name: result.right.results[index].name,
          ),
        );
        category.insert(0, CatigoryList(name: "ALL"));
        emit(state.copyWith(
          categoryList: result.right.results,
          category: category,
          status: FormzSubmissionStatus.success,
        ));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });

    on<GetMoreCategory>((event, emit) async {
      CatigoryFilter param = CatigoryFilter(
        offset: state.categoryList.length,
        search: state.search.isEmpty ? null : state.search,
      );
      final result = await useCase.call(param);
      if (result.isRight) {
        emit(state.copyWith(
          categoryList: [...state.categoryList, ...result.right.results],
          count: result.right.count,
          statusP: FormzSubmissionStatus.success,
        ));
      } else {
        emit(state.copyWith(statusP: FormzSubmissionStatus.failure));
      }
    });

    on<SelectionIndex>(
      (event, emit) => emit(state.copyWith(selIndex: event.index)),
    );
  }
}
