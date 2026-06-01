import 'package:flutter_github_api/features/users/domain/entities/user_details_entity.dart';
import 'package:flutter_github_api/features/users/presentation/providers/user_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_details_notifier.g.dart';

@riverpod
class UserDetailsNotifier extends _$UserDetailsNotifier {
  @override
  Future<UserDetailsEntity> build(String username) async {
    return _fetchDetails(username);
  }

  Future<UserDetailsEntity> _fetchDetails(String username) async {
    final result = await ref
        .read(userRepoProvider)
        .getUserDetails(username: username);

    return result.when(success: (details) => details, error: (e) => throw e);
  }

  Future<void> refresh() async {
    final username = state.value?.username;
    if (username == null) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchDetails(username));
  }
}
