import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/self_assesment/data/model/category_model.dart';
import 'package:bloc_test/feature/self_assesment/domain/repository/assesment_repo.dart';

class GetAllCategory implements UseCase<List<CategoryModel>, NoParams> {
  final AssesmentRepo repository;

  GetAllCategory(this.repository);

  @override
  Future<List<CategoryModel>> call(params) async {
    return await repository.getAllCategory();
  }
}
