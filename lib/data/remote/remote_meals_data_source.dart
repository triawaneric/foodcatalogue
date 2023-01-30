import 'package:foodcatalogue/data/models/meals_response_model.dart';
import 'package:foodcatalogue/data/remote/web_service.dart';

class RemoteMealsDataSource {
  RemoteMealsDataSource._privateConstructor();

  static final RemoteMealsDataSource _instance =
      RemoteMealsDataSource._privateConstructor();

  factory RemoteMealsDataSource() {
    return _instance;
  }

  WebService webService = WebService();

  Future<List<Meal>> getMealsByCategory(String category) =>
      this.webService.getMealsByCategory(category);

  Future<List<Meal>> getMealById(String id) => this.webService.getMealById(id);
}
