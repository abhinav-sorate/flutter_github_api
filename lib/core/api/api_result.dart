import 'package:flutter_github_api/core/constants/status.enum.dart';

class ApiResult<T> {
  final T? data;
  final ApiStatus status;
  final dynamic exception;

  ApiResult({this.data, this.status = ApiStatus.loading, this.exception});

  factory ApiResult.success(T data) {
    return ApiResult(data: data, status: ApiStatus.success);
  }

  factory ApiResult.error(dynamic e) {
    return ApiResult(exception: e, status: ApiStatus.success);
  }
}
