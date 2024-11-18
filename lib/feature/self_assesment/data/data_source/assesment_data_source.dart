import 'package:bloc_test/feature/self_assesment/data/model/category_model.dart';

abstract interface class AssesmentDataSource {
  Future<List<CategoryModel>> getAllCategory();
  Future<List<CategoryModel>> searchCategory();
}
