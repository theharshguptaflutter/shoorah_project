import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc_test/core/constants/api_endpoints.dart';
import 'package:bloc_test/core/exceptions/app_exceptions.dart';
import 'package:bloc_test/core/network/http_client/network/http_client.dart';
import 'package:http/http.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:retry/retry.dart';

class HttpClientImpl extends HttpClient {
  final r = const RetryOptions(maxAttempts: 3);

  static const seconds = 60;
  static const headers = {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*",
    'Access-Control-Allow-Headers': 'Content-Type',
    "content-type": "application/json",
  };

  HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
    HttpLogger(logLevel: LogLevel.HEADERS),
  ]);

  Future<Response> retryMethod(
    FutureOr<Response> Function() fn,
  ) {
    return r.retry(
      fn,
      retryIf: (e) => e is TimeoutException,
    );
  }

  @override
  Future getGetApiResponse(String path, Map<String, dynamic>? queryParameter,
      [String baseUrl = ApiEndPoint.baseUrl]) async {
    dynamic responseJson;
    try {
      final response = await retryMethod(
        () => http
            .get(
                Uri.http(
                  baseUrl,
                  path,
                  queryParameter,
                ),
                headers: headers)
            .timeout(
              const Duration(seconds: seconds),
            ),
      );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet");
    }

    return responseJson;
  }

//-----------------------get post api response-------------------//
  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;

    try {
      Response response = await retryMethod(() => post(
            Uri.http(ApiEndPoint.baseUrl, url),
            body: json.encode(data),
            headers: {
              "Accept": "application/json",
              'Access-Control-Allow-Headers': 'Content-Type',
              "Access-Control-Allow-Origin": "*",
              "content-type": "application/json",

              //------------//
            },
          ).timeout(
            const Duration(seconds: seconds),
          ));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

  //--------------------------Put api response-------------------//

  @override
  Future getPutApiResponse(
    String url,
    dynamic data,
  ) async {
    dynamic responseJson;

    try {
      Response response = await retryMethod(() => put(
            Uri.http(
              ApiEndPoint.baseUrl,
              url,
            ),
            body: json.encode(data),
            headers: {
              "Accept": "application/json",
              "content-type": "application/json",
              "Access-Control-Allow-Origin": "*",
            },
          ).timeout(
            const Duration(seconds: seconds),
          ));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

  //-----------------------Path api response--------------------------//

  @override
  Future getPatchApiResponse(
    String url,
    dynamic data,
  ) async {
    dynamic responseJson;

    try {
      Response response = await retryMethod(() => patch(
            Uri.http(
              ApiEndPoint.baseUrl,
              url,
            ),
            body: json.encode(data),
            headers: headers,
          ).timeout(
            const Duration(seconds: seconds),
          ));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

  //--------------------------Delete api response-------------------//
  @override
  Future getDeleteApiResponse(String url, dynamic data) async {
    dynamic responseJson;

    try {
      Response response = await retryMethod(
        () => delete(
          Uri.http(
            ApiEndPoint.baseUrl,
            url,
          ),
          body: json.encode(data),
          headers: headers,
        ).timeout(
          const Duration(seconds: seconds),
        ),
      );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future multiPartApiResponse(String url, Map<String, String> data, File file,
      {MethodType methodType = MethodType.POST,
      String fileName = "image"}) async {
    dynamic responseJson;

    try {
      var request = MultipartRequest(
        methodType.name,
        Uri.http(
          ApiEndPoint.baseUrl,
          url,
        ),
      );
      request.headers.addAll(headers);
      request.files.add(await MultipartFile.fromPath(fileName, file.path));
      request.fields.addAll(data);
      StreamedResponse streamResponse = await request.send().timeout(
            const Duration(seconds: seconds),
          );
      Response response =
          await convertStreamedResponseToResponse(streamResponse);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  Future<Response> convertStreamedResponseToResponse(
      StreamedResponse streamedResponse) async {
    final bytes = await streamedResponse.stream.toBytes();
    final response = Response.bytes(bytes, streamedResponse.statusCode,
        headers: streamedResponse.headers);
    return response;
  }

  dynamic returnResponse(Response response) {
    Map<String, dynamic> error =
        jsonDecode(response.body) as Map<String, dynamic>;

    switch (response.statusCode) {
      case 200:
        // dynamic responseJson = response.body;
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(
          response.body.toString(),
        );
      case 404:
        throw UnauthorisedException(
          error['mess'],
        );
      case 505:
        throw InvalidInputException(
          response.body.toString(),
        );
      case 500:
        throw InternalServerException(
          response.body.toString(),
        );
      case 401:
        throw UnAuthorizedException(
          error['mess'],
        );
      case 409:
        throw ConflictException(
          error['mess'],
        );
      case 503:
        throw ServiceUnavailableException(
          "Service Unavailable",
        );
      default:
        throw FetchDataException(
          "Error occured while communicating with server with status code${response.statusCode}",
        );
    }
  }
}
