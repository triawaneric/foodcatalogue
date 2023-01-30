part of 'meal_bloc.dart';

@immutable
abstract class MealEvent {}

class OnGetMeals extends MealEvent {
  final String category;

  OnGetMeals({this.category});
}
