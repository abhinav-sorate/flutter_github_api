// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_repos_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserReposNotifier)
final userReposProvider = UserReposNotifierFamily._();

final class UserReposNotifierProvider
    extends $AsyncNotifierProvider<UserReposNotifier, List<UserRepoEntity>> {
  UserReposNotifierProvider._({
    required UserReposNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userReposProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userReposNotifierHash();

  @override
  String toString() {
    return r'userReposProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UserReposNotifier create() => UserReposNotifier();

  @override
  bool operator ==(Object other) {
    return other is UserReposNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userReposNotifierHash() => r'26e7296132b5790d00ffbe967fb2c52fabdb79a4';

final class UserReposNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          UserReposNotifier,
          AsyncValue<List<UserRepoEntity>>,
          List<UserRepoEntity>,
          FutureOr<List<UserRepoEntity>>,
          String
        > {
  UserReposNotifierFamily._()
    : super(
        retry: null,
        name: r'userReposProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserReposNotifierProvider call(String username) =>
      UserReposNotifierProvider._(argument: username, from: this);

  @override
  String toString() => r'userReposProvider';
}

abstract class _$UserReposNotifier
    extends $AsyncNotifier<List<UserRepoEntity>> {
  late final _$args = ref.$arg as String;
  String get username => _$args;

  FutureOr<List<UserRepoEntity>> build(String username);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<UserRepoEntity>>, List<UserRepoEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<UserRepoEntity>>,
                List<UserRepoEntity>
              >,
              AsyncValue<List<UserRepoEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
