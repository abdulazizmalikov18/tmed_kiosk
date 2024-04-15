part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final FormzSubmissionStatus status;
  final FormzSubmissionStatus statusP;
  final List<CategoryEntity> categoryList;
  final List<CatigoryList> category;
  final int count;
  final String search;
  final int selIndex;
  const CategoryState({
    this.status = FormzSubmissionStatus.initial,
    this.statusP = FormzSubmissionStatus.initial,
    this.categoryList = const [],
    this.count = 0,
    this.search = '',
    this.category = const [],
    this.selIndex = 0,
  });

  CategoryState copyWith({
    FormzSubmissionStatus? status,
    FormzSubmissionStatus? statusP,
    bool? isImage,
    List<CategoryEntity>? categoryList,
    int? count,
    String? search,
    List<CatigoryList>? category,
    int? selIndex,
  }) =>
      CategoryState(
        status: status ?? this.status,
        statusP: statusP ?? this.statusP,
        categoryList: categoryList ?? this.categoryList,
        count: count ?? this.count,
        search: search ?? this.search,
        category: category ?? this.category,
        selIndex: selIndex ?? this.selIndex,
      );

  @override
  List<Object> get props => [status, statusP, categoryList, count, search, category, selIndex];
}
