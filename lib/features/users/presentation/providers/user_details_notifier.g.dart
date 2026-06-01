// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserDetailsNotifier)
final userDetailsProvider = UserDetailsNotifierFamily._();

final class UserDetailsNotifierProvider
    extends $AsyncNotifierProvider<UserDetailsNotifier, UserDetailsEntity> {
  UserDetailsNotifierProvider._({
    required UserDetailsNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userDetailsNotifierHash();

  @override
  String toString() {
    return r'userDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UserDetailsNotifier create() => UserDetailsNotifier();

  @override
  bool operator ==(Object other) {
    return other is UserDetailsNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userDetailsNotifierHash() =>
    r'c0ee9fc5a4c38c99ddc5b3ed88abdcee391d363f';

final class UserDetailsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          UserDetailsNotifier,
          AsyncValue<UserDetailsEntity>,
          UserDetailsEntity,
          FutureOr<UserDetailsEntity>,
          String
        > {
  UserDetailsNotifierFamily._()
    : super(
        retry: null,
        name: r'userDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserDetailsNotifierProvider call(String username) =>
      UserDetailsNotifierProvider._(argument: username, from: this);

  @override
  String toString() => r'userDetailsProvider';
}

abstract class _$UserDetailsNotifier extends $AsyncNotifier<UserDetailsEntity> {
  late final _$args = ref.$arg as String;
  String get username => _$args;

  FutureOr<UserDetailsEntity> build(String username);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<UserDetailsEntity>, UserDetailsEntity>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserDetailsEntity>, UserDetailsEntity>,
              AsyncValue<UserDetailsEntity>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
