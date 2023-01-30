import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:foodcatalogue/data/models/category_response_model.dart';
import 'package:foodcatalogue/domain/category_repository_implement.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryState());

  final repository = CategoryRepositoryImplement();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is OnGetCategories) {
      yield* this.onGetCategories();
    }
  }

  Stream<CategoryState> onGetCategories() async* {
    try {
      yield LoadingCategories();
      final data = await this.repository.getCategories();
      yield state.copyWith(categories: data);
    } catch (error) {
      yield FailureCategories(error: error.toString());
    }
  }
}
