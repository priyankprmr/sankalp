abstract class ApiResult {}

class Success<T> extends ApiResult {
  T? response;
  Success({this.response});
}

class Failure<T> extends ApiResult {
  T? response;
  Failure({this.response});
}
