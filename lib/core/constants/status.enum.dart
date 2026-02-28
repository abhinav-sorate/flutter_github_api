enum ApiStatus { initial, loading, success, error, notFound }

extension ApiStatusX on ApiStatus {
  bool get isInitial => this == ApiStatus.initial;
  bool get isLoading => this == ApiStatus.loading;
  bool get isSuccess => this == ApiStatus.success;
  bool get isError => this == ApiStatus.error;
  bool get isNotFound => this == ApiStatus.notFound;
}
