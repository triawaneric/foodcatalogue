part of 'category_bloc.dart';

@immutable
class CategoryState {
  final List<Category> categories;

  CategoryState({List<Category> categories})
      : this.categories = categories ?? [];

  CategoryState copyWith({List<Category> categories}) =>
      CategoryState(categories: categories ?? this.categories);
}

class LoadingCategories extends CategoryState {}

class FailureCategories extends CategoryState {
  final String error;

  FailureCategories({this.error});
}
