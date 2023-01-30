import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:foodcatalogue/data/models/meals_response_model.dart';
import 'package:foodcatalogue/domain/meals_repository_implement.dart';

import 'package:meta/meta.dart';

part 'meal_detail_event.dart';
part 'meal_detail_state.dart';

class MealDetailBloc extends Bloc<MealDetailEvent, MealDetailState> {
  MealDetailBloc() : super(MealDetailState());
  final repository = MealsRepositoryImplement();

  @override
  Stream<MealDetailState> mapEventToState(MealDetailEvent event) async* {
    if (event is OnGetMeal) {
      yield* this.onGetMel(event.id);
    }
  }

  Stream<MealDetailState> onGetMel(String id) async* {
    try {
      yield LoadingMeal();
      final data = await this.repository.getMealById(id);
      yield state.copyWith(meal: data[0]);
    } catch (error) {
      print(error.toString());
      yield FailureMeal(error: error.toString());
    }
  }
}
