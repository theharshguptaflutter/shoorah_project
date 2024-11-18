import 'package:bloc_test/feature/self_assesment/domain/entity/category.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel(
      {required super.categoryIcon,
      required super.categoryName,
      required super.totalQuizees,
      required super.categoryDesc,
      required super.testTime,
      });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryIcon: json['category_icon'],
      categoryName: json['category_name'],
      totalQuizees: json['total_quizees'],
      categoryDesc: json['category_desc'],
      testTime: json['test_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_icon': categoryIcon,
      'category_name': categoryName,
      'total_quizees': totalQuizees,
      'category_desc': categoryDesc,
      'test_time': testTime,

    };
  }
}
