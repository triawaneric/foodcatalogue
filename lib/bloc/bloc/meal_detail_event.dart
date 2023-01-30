part of 'meal_detail_bloc.dart';

@immutable
abstract class MealDetailEvent {}

class OnGetMeal extends MealDetailEvent {
  final String id;

  OnGetMeal({this.id});
}
