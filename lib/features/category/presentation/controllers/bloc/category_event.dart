part of 'category_bloc.dart';

abstract class CategoryEvent {}

class GetCategory extends CategoryEvent {
  final String? search;
  final bool isOfline;

  GetCategory({this.search, this.isOfline = false});
}

class GetCategoryApi extends CategoryEvent {
  final int limit;

  GetCategoryApi({this.limit = 0});
}

class GetMoreCategory extends CategoryEvent {}

class SelectionIndex extends CategoryEvent {
  final int index;

  SelectionIndex({required this.index});
}
