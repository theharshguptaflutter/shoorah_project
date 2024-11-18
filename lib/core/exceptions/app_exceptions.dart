class AppException implements Exception {
  final _message;

  AppException([
    this._message,
  ]);

  @override
  String toString() {
    return '$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? super.message]);
}

class BadRequestException extends AppException {
  BadRequestException([String? super.message]);
}

class TemporaryUnavailableException extends AppException {
  TemporaryUnavailableException([String? super.message]);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? super.message]);
}

class InvalidInputException extends AppException {
  InvalidInputException([String? super.message]);
}

class NoInternetException extends AppException {
  NoInternetException([String? super.message]);
}

class InternalServerException extends AppException {
  InternalServerException([String? super.message]);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? super.message]);
}

class ConflictException extends AppException {
  ConflictException([String? super.message]);
}

class ServiceUnavailableException extends AppException {
  ServiceUnavailableException([String? super.message]);
}
