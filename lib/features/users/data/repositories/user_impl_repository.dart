import 'package:flutter_github_api/core/api/api_endpoints.dart';
import 'package:flutter_github_api/core/api/api_result.dart';
import 'package:flutter_github_api/core/api/client.dart';
import 'package:flutter_github_api/features/users/data/models/user_details_model.dart';
import 'package:flutter_github_api/features/users/data/models/user_repos_model.dart';
import 'package:flutter_github_api/features/users/domain/entities/user_details_entity.dart';
import 'package:flutter_github_api/features/users/domain/entities/user_repo_entity.dart';
import 'package:flutter_github_api/features/users/domain/repositories/user_repository.dart';
import 'package:flutter_github_api/features/users/data/models/user_list_model.dart';
import 'package:flutter_github_api/features/users/domain/entities/user_list_entity.dart';

class UserRepoImpl extends UserRepo {
  final ApiClient _client;
  UserRepoImpl({required ApiClient client}) : _client = client;

  @override
  Future<ApiResult<List<UserListEntity>>> searchUsers({
    required String keyword,
    required int page,
    int perPage = 30,
  }) async {
    try {
      final response = await _client.get(
        path: ApiEndpoints.user.searchUsers(keyword: keyword),
        queryParameters: {'page': page, 'per_page': perPage},
      );
      final List items = response.data['items'];
      final users = items
          .map(
            (e) => UserListModel.fromJson(e as Map<String, dynamic>).toEntity(),
          )
          .toList();

      return ApiResult.success(users);
    } catch (e) {
      return ApiResult.error(e);
    }
  }

  @override
  Future<ApiResult<UserDetailsEntity>> getUserDetails({
    required String username,
  }) async {
    try {
      final response = await _client.get(
        path: ApiEndpoints.user.getUserDetails(username: username),
      );
      final user = UserDetailsModel.fromJson(
        response.data as Map<String, dynamic>,
      ).toEntity();
      return ApiResult.success(user);
    } catch (e) {
      return ApiResult.error(e);
    }
  }

  @override
  Future<ApiResult<List<UserRepoEntity>>> getUserRepos({
    required String username,
  }) async {
    try {
      final response = await _client.get(
        path: ApiEndpoints.user.getUserRepos(username: username),
      );

      final data = response.data as List;

      final repos = data
          .map((e) => UserReposModel.fromJson(e as Map<String, dynamic>))
          .where((repo) => !repo.fork)
          .map((repo) => repo.toEntity())
          .toList();
      return ApiResult.success(repos);
    } catch (e) {
      return ApiResult.error(e);
    }
  }
}
