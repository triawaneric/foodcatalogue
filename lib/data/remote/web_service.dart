
import 'package:foodcatalogue/data/models/category_response_model.dart';
import 'package:foodcatalogue/data/models/meals_response_model.dart';

import 'package:dio/dio.dart';

class WebService {
  WebService._privateConstructor();
  var dio = Dio();

  static final WebService _instance = WebService._privateConstructor();

  factory WebService() {
    return _instance;
  }

  Future<List<Category>> getCategories() async {
    final url = Uri.https("www.themealdb.com", "/api/json/v1/1/categories.php");
    final response = await dio.get("https://www.themealdb.com/api/json/v1/1/categories.php");
    final list = CategoryResponse.fromJson(response.data);
    return list.categories;
  }

  Future<List<Meal>> getMealsByCategory(String category) async {
    final response = await dio.get("https://www.themealdb.com/api/json/v1/1/filter.php",queryParameters: {'c':category});
    final list = MealsResponse.fromJson(response.data);
    return list.meals;
  }

  Future<List<Meal>> getMealById(String id) async {

    final response = await dio.get("https://www.themealdb.com/api/json/v1/1/lookup.php",queryParameters: {'i':id});
    final list = MealsResponse.fromJson(response.data);
    return list.meals;
  }
}
