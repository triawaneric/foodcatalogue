

import 'package:foodcatalogue/data/models/category_response_model.dart';
import 'package:foodcatalogue/data/remote/web_service.dart';

class RemoteCategoryDataSource {
  RemoteCategoryDataSource._privateConstructor();

  static final RemoteCategoryDataSource _instance =
      RemoteCategoryDataSource._privateConstructor();

  factory RemoteCategoryDataSource() {
    return _instance;
  }

  WebService webService = WebService();

  Future<List<Category>> getCategories() => this.webService.getCategories();
}
