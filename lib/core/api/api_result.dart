import 'package:flutter_github_api/core/constants/status.enum.dart';

class ApiResult<T> {
  final T? data;
  final ApiStatus status;
  final dynamic exception;

  const ApiResult({this.data, required this.status, this.exception});

  factory ApiResult.success(T data) {
    return ApiResult(data: data, status: ApiStatus.success);
  }

  factory ApiResult.error(dynamic e) {
    return ApiResult(status: ApiStatus.error, exception: e);
  }

  factory ApiResult.notFound() {
    return ApiResult(status: ApiStatus.notFound);
  }

  bool get hasData => data != null && status.isSuccess;
  bool get hasError => status.isError || status.isNotFound;
}
