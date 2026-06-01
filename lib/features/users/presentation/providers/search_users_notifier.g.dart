// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_users_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchUsersNotifier)
final searchUsersProvider = SearchUsersNotifierProvider._();

final class SearchUsersNotifierProvider
    extends
        $NotifierProvider<
          SearchUsersNotifier,
          AsyncValue<List<UserListEntity>>
        > {
  SearchUsersNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchUsersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchUsersNotifierHash();

  @$internal
  @override
  SearchUsersNotifier create() => SearchUsersNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<UserListEntity>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<UserListEntity>>>(
        value,
      ),
    );
  }
}

String _$searchUsersNotifierHash() =>
    r'b7195f69090c83e51d985f78bb6a886bfeec9674';

abstract class _$SearchUsersNotifier
    extends $Notifier<AsyncValue<List<UserListEntity>>> {
  AsyncValue<List<UserListEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<UserListEntity>>,
              AsyncValue<List<UserListEntity>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<UserListEntity>>,
                AsyncValue<List<UserListEntity>>
              >,
              AsyncValue<List<UserListEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
