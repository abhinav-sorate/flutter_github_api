// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_repo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(apiClient)
final apiClientProvider = ApiClientProvider._();

final class ApiClientProvider
    extends $FunctionalProvider<ApiClient, ApiClient, ApiClient>
    with $Provider<ApiClient> {
  ApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiClientHash();

  @$internal
  @override
  $ProviderElement<ApiClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApiClient create(Ref ref) {
    return apiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiClient>(value),
    );
  }
}

String _$apiClientHash() => r'15bdba30fb06f6ed56dba4fc45c2425cdd009f8c';

@ProviderFor(userRepo)
final userRepoProvider = UserRepoProvider._();

final class UserRepoProvider
    extends $FunctionalProvider<UserRepo, UserRepo, UserRepo>
    with $Provider<UserRepo> {
  UserRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userRepoHash();

  @$internal
  @override
  $ProviderElement<UserRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserRepo create(Ref ref) {
    return userRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserRepo>(value),
    );
  }
}

String _$userRepoHash() => r'3889956ab6eb1ebac2fb47d07154eb17a3c4bdc1';
