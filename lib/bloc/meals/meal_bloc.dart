import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:foodcatalogue/data/models/meals_response_model.dart';
import 'package:foodcatalogue/domain/meals_repository_implement.dart';
import 'package:meta/meta.dart';

part 'meal_event.dart';
part 'meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealsState> {
  MealBloc() : super(MealsState());
  final repository = MealsRepositoryImplement();
  @override
  Stream<MealsState> mapEventToState(MealEvent event) async* {
    if (event is OnGetMeals) {
      yield* this.onGetMeals(event.category);
    }
  }

  Stream<MealsState> onGetMeals(String category) async* {
    try {
      yield LoadingMeals();
      final data = await this.repository.getMealsByCategory(category);
      yield state.copyWith(meals: data);
    } catch (error) {
      print(error.toString());
      yield FailureMeals(error: error.toString());
    }
  }
}
