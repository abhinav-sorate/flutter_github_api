import 'dart:async';

import 'package:flutter_github_api/features/users/domain/entities/user_list_entity.dart';
import 'package:flutter_github_api/features/users/presentation/providers/user_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_users_notifier.g.dart';

@riverpod
class SearchUsersNotifier extends _$SearchUsersNotifier {
  Timer? _debounce;
  static const _perPage = 30;

  int _page = 1;
  bool _hasMore = true;
  String _currentKeyword = '';
  List<UserListEntity> _users = [];

  @override
  AsyncValue<List<UserListEntity>> build() => const AsyncData([]);

  Future<void> search(String keyword) async {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (keyword.trim().isEmpty) {
        clear();
        return;
      }

      // Reset state for new search
      _page = 1;
      _hasMore = true;
      _currentKeyword = keyword;
      _users = [];

      state = const AsyncLoading();

      final result = await ref
          .read(userRepoProvider)
          .searchUsers(keyword: keyword, page: _page, perPage: _perPage);

      result.when(
        success: (users) {
          _hasMore = users.length == _perPage;
          _users = users;
          state = AsyncData([..._users]);
        },
        error: (e) => state = AsyncError(e, StackTrace.current),
      );
    });
  }

  Future<void> loadMore() async {
    if (!_hasMore || state is AsyncLoading || _currentKeyword.isEmpty) return;

    _page++;

    final result = await ref
        .read(userRepoProvider)
        .searchUsers(keyword: _currentKeyword, page: _page, perPage: _perPage);

    result.when(
      success: (users) {
        _hasMore = users.length == _perPage;
        _users = [..._users, ...users];
        state = AsyncData([..._users]);
      },
      error: (e) {
        _page--; // rollback on failure
        state = AsyncError(e, StackTrace.current);
      },
    );
  }

  void clear() {
    _page = 1;
    _hasMore = true;
    _currentKeyword = '';
    _users = [];
    state = const AsyncData([]);
  }

  bool get hasMore => _hasMore;
  String get currentKeyword => _currentKeyword;
}
