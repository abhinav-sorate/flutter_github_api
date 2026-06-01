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

  R when<R>({
    required R Function(T data) success,
    required R Function(dynamic error) error,
    R Function()? notFound,
  }) {
    switch (status) {
      case ApiStatus.success:
        return success(data as T);
      case ApiStatus.error:
        return error(exception);
      case ApiStatus.notFound:
        return notFound != null ? notFound() : error(exception);
    }
  }
}