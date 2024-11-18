import 'package:bloc_test/core/constants/api_endpoints.dart';
import 'package:bloc_test/core/network/http_client/network/http_client.dart';
import 'package:bloc_test/feature/self_assesment/data/data_source/assesment_data_source.dart';
import 'package:bloc_test/feature/self_assesment/data/model/category_model.dart';

class AssesmentRemoteDataSourceImpl implements AssesmentDataSource {
  final HttpClient httpClientService;

  AssesmentRemoteDataSourceImpl({required this.httpClientService});

  @override
  Future<List<CategoryModel>> getAllCategory() async {
    List<CategoryModel> pixaImageData = [];
    try {
      final response =
          await httpClientService.getGetApiResponse(ApiEndPoint.baseUrl, {});
      CategoryModel pixaImagesModel = CategoryModel.fromJson(response);
      pixaImageData = [pixaImagesModel];
    } on Exception {
      rethrow;
    }
    return pixaImageData;
  }

  @override
  Future<List<CategoryModel>> searchCategory() async {
    List<CategoryModel> pixaImageData = [];
    try {
      final response =
          await httpClientService.getGetApiResponse(ApiEndPoint.baseUrl, {});
      CategoryModel pixaImagesModel = CategoryModel.fromJson(response);
      pixaImageData = [pixaImagesModel];
    } on Exception {
      rethrow;
    }
    return pixaImageData;
  }
}
