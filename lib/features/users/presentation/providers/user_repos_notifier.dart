import 'package:flutter_github_api/features/users/domain/entities/user_repo_entity.dart';
import 'package:flutter_github_api/features/users/presentation/providers/user_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repos_notifier.g.dart';

@riverpod
class UserReposNotifier extends _$UserReposNotifier {
  static const _perPage = 30;

  int _page = 1;
  bool _hasMore = true;
  List<UserRepoEntity> _repos = [];

  @override
  Future<List<UserRepoEntity>> build(String username) async {
    return _fetchRepos(username);
  }

  Future<List<UserRepoEntity>> _fetchRepos(String username) async {
    final result = await ref.read(userRepoProvider).getUserRepos(
          username: username,
          page: _page,
          perPage: _perPage,
        );

    return result.when(
      success: (repos) {
        _hasMore = repos.length == _perPage;
        _repos = [..._repos, ...repos];
        return [..._repos];
      },
      error: (e) => throw e,
    );
  }

  Future<void> loadMore(String username) async {
    if (!_hasMore || state is AsyncLoading) return;

    _page++;
    state = await AsyncValue.guard(() => _fetchRepos(username));

    if (state is AsyncError) _page--; // rollback on failure
  }

  Future<void> refresh(String username) async {
    _page = 1;
    _hasMore = true;
    _repos = [];

    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchRepos(username));
  }

  bool get hasMore => _hasMore;
}