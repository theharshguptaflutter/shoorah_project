import 'dart:convert';
import 'dart:io';

import 'package:bloc_test/feature/self_assesment/data/data_source/assesment_data_source.dart';
import 'package:bloc_test/feature/self_assesment/data/model/category_model.dart';
import 'dart:convert';
import 'package:flutter/services.dart';  // Import rootBundle


class AssesmentLocalDataSourceImpl implements AssesmentDataSource {
  @override
Future<List<CategoryModel>> getAllCategory() async {
  // Load the JSON file from the assets using rootBundle
  final String response = await rootBundle.loadString('assets/json_values/assesment_json_values.json');
  
  // Decode the JSON string into a Dart object (List<dynamic>)
  final List<dynamic> data = jsonDecode(response); // This is a List<dynamic>

  // Convert the List<dynamic> into a List<CategoryModel>
  List<CategoryModel> categoryModelList = data.map((item) => CategoryModel.fromJson(item)).toList();

  return categoryModelList;
}

  @override
  Future<List<CategoryModel>> searchCategory() {
    throw UnimplementedError();
  }
}
