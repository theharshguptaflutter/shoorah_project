import 'dart:io';

enum MethodType { GET, POST, PUT, PATCH, DELETE, MULTIPART }

abstract class HttpClient {
  Future<dynamic> getGetApiResponse(
      String path, Map<String, dynamic>? queryParameter,
      [String baseUrl]);

  Future<dynamic> getPostApiResponse(String url, dynamic data);

  Future<dynamic> getPutApiResponse(
    String url,
    dynamic data,
  );

  Future<dynamic> getPatchApiResponse(
    String url,
    dynamic data,
  );

  Future<dynamic> getDeleteApiResponse(
    String url,
    dynamic data,
  );

  Future<dynamic> multiPartApiResponse(
      String url, Map<String, String> data, File file,
      {MethodType methodType, String fileName});

  // Future<void> connectSocketIO(String email);

  // Stream<dynamic> listenToSocketIO(String event);

  // Future<void> closeSocketIO();

  // Future<dynamic> computeGetApiResponse(
  //     String path, Map<String, dynamic> queryParameter,
  //     [String baseUrl]);
}
