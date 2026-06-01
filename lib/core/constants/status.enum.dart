enum ApiStatus { success, error, notFound }

extension ApiStatusX on ApiStatus {
  bool get isSuccess => this == ApiStatus.success;
  bool get isError => this == ApiStatus.error;
  bool get isNotFound => this == ApiStatus.notFound;
}
