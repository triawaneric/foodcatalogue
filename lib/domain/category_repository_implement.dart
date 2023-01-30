

import 'package:foodcatalogue/data/models/category_response_model.dart';
import 'package:foodcatalogue/data/remote/remote_category_data_source.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
}

class CategoryRepositoryImplement implements CategoryRepository {
  RemoteCategoryDataSource remoteDataSource = RemoteCategoryDataSource();

  CategoryRepositoryImplement._privateConstructor();

  static final CategoryRepositoryImplement _instance =
      CategoryRepositoryImplement._privateConstructor();

  factory CategoryRepositoryImplement() {
    return _instance;
  }

  @override
  Future<List<Category>> getCategories() =>
      this.remoteDataSource.getCategories();
}
