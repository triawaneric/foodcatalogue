import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodcatalogue/bloc/bloc/meal_detail_bloc.dart';
import 'package:foodcatalogue/data/models/meals_response_model.dart';
import 'package:foodcatalogue/pages/home_page.dart';


class MealPage extends StatelessWidget {
  final Meal meal;
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  MealPage({Key key, this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MealDetailBloc>(context);
    bloc.add(OnGetMeal(id: this.meal.idMeal));
    return Scaffold(
      key: _scaffoldState,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            expandedHeight: 100,
            floating: false,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Text(
                this.meal.strMeal,
                overflow: TextOverflow.ellipsis,
              ),
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      this.meal.strMealThumb ??
                          "https://images.unsplash.com/photo-1482049016688-2d3e1b311543?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1553&q=80",
                    ),
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
        ],
        body: Column(
          children: [
            //DropDown
            //DropdownButton(items: items, onChanged: onChanged),
            
            
            //Listview 

            BlocBuilder<MealDetailBloc, MealDetailState>(
              builder: (context, state) {
                if (state is LoadingMeal) {
                  return Loading();
                } else if (state is MealDetailState) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _getSections(context, state.meal),
                        _getInfotmation(context, state.meal),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getInfotmation(BuildContext context, Meal meal) {
    final tagList = meal?.strTags != null ? meal.strTags.split(",") : [];
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleSection("Instructions"),
          Text(
            meal?.strInstructions != null ? meal.strInstructions : "",
            textAlign: TextAlign.justify,
          ),
          _titleSection("Tags"),
          Container(
            height: 40,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tagList.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      tagList[index],
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleSection(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
        ),
      ),
    );
  }

  Widget _getSections(BuildContext context, Meal meal) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          mealSection(
              title: 'Category',
              description: meal?.strCategory != null ? meal.strCategory : ""),
          mealSection(
              title: 'Area',
              description: meal?.strArea != null ? meal.strArea : ""),
        ],
      ),
    );
  }

  Widget mealSection({String title, String description}) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.all(10),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
