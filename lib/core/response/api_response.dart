import '../exceptions/status.dart';

class ApiResponse<T> {
  Status status;
  T? data;
  String? message;

  ApiResponse({this.status = Status.loading, this.data, this.message});

  ApiResponse.loading() : status = Status.loading;

  ApiResponse.completed(this.data) : status = Status.completed;

  ApiResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return "Status : $status \n Message: $message \n Data: $data";
  }
}

class ApiResponse2<T> {
  Status2? status;
  T? data;
  String? message;

  ApiResponse2({this.status, this.data, this.message});

  ApiResponse2.loading() : status = Status2.loading;

  ApiResponse2.completed(this.data) : status = Status2.completed;

  ApiResponse2.error(this.message) : status = Status2.error;

  ApiResponse2.initial() : status = Status2.initial;

  @override
  String toString() {
    return "Status : $status \n Message: $message \n Data: $data";
  }
}
