part of 'meal_bloc.dart';

@immutable
class MealsState {
  final List<Meal> meals;

  MealsState({List<Meal> meals}) : this.meals = meals ?? [];

  MealsState copyWith({
    List<Meal> meals,
  }) =>
      MealsState(
        meals: meals ?? this.meals,
      );
}

class LoadingMeals extends MealsState {}

class FailureMeals extends MealsState {
  final String error;

  FailureMeals({this.error});
}
