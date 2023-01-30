part of 'meal_detail_bloc.dart';

@immutable
class MealDetailState {
  final Meal meal;

  MealDetailState({Meal meal}) : this.meal = meal ?? null;

  MealDetailState copyWith({
    Meal meal,
  }) =>
      MealDetailState(
        meal: meal ?? this.meal,
      );
}

class FailureMeal extends MealDetailState {
  final String error;

  FailureMeal({this.error});
}

class LoadingMeal extends MealDetailState {}
