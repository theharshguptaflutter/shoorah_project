import 'package:bloc_test/feature/self_assesment/data/data_source/assesment_data_source.dart';
import 'package:bloc_test/feature/self_assesment/data/model/category_model.dart';
import 'package:bloc_test/feature/self_assesment/domain/repository/assesment_repo.dart';

class AssesmentRepoImpl implements AssesmentRepo {
  final AssesmentDataSource dataSource;

  AssesmentRepoImpl(this.dataSource);

  @override
  Future<List<CategoryModel>> getAllCategory() async {
    return await dataSource.getAllCategory();
  }

  @override
  Future<List<CategoryModel>> searchCategory() {
    return dataSource.searchCategory();
  }
}
