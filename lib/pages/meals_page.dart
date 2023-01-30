import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodcatalogue/bloc/meals/meal_bloc.dart';
import 'package:foodcatalogue/data/models/meals_response_model.dart';
import 'package:foodcatalogue/pages/home_page.dart';


class MealsPage extends StatelessWidget {
  final ScreenArguments arguments;
  MealsPage(this.arguments);
  @override
  Widget build(BuildContext context) {
    //final a = ModalRoute.of(context)?.settings?.arguments;
    // print("Argss?? ${a}");
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            title: Row(
              children: [
                // Icon(Icons.arrow_back, color: Colors.black),
                SizedBox(
                  width: 10,
                ),
                Text(
                  this.arguments.category,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                )
              ],
            ),
            backgroundColor: Colors.white,
            expandedHeight: 50,
            floating: false,
            pinned: true,
            elevation: 0,
          )
        ],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 10),
              child: Text(
                "Results for ${this.arguments.category}",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
            ),
            this._getMeals(context),
          ],
        ),
      ),
    );
  }

  Widget _getMeals(BuildContext context) {
    final bloc = BlocProvider.of<MealBloc>(context);
    bloc.add(OnGetMeals(category: this.arguments.category));
    return Container(
      child: BlocBuilder<MealBloc, MealsState>(
        builder: (context, state) {
          if (state is LoadingMeals) {
            return Loading();
          } else if (state is FailureMeals) {
            return Error(
              message: state.error,
            );
          } else if (state is MealsState) {
            return Expanded(
              child: ListView.builder(
                itemCount: state.meals.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return MealCard(meal: state.meals[index]);
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class MealCard extends StatelessWidget {
  final Meal meal;
  MealCard({Key key, this.meal}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          'meal',
          arguments: this.meal,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
        ),
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(this.meal.strMeal,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(this.meal.idMeal,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 17.0,
                        )),
                  ],
                ),
              ),
            ),
            Image(
              width: 200,
              height: 150,
              fit: BoxFit.cover,
              image: NetworkImage(
                this.meal.strMealThumb ??
                    "https://images.unsplash.com/photo-1482049016688-2d3e1b311543?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1553&q=80",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
