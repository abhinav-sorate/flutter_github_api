import 'package:flutter_github_api/core/api/api_endpoints.dart';
import 'package:flutter_github_api/core/api/api_result.dart';
import 'package:flutter_github_api/core/api/client.dart';
import 'package:flutter_github_api/core/repository/user_repository.dart';
import 'package:flutter_github_api/features/users/data/models/user_list_model.dart';
import 'package:flutter_github_api/features/users/domain/entities/user_list_entity.dart';

class UserRepoImpl extends UserRepo {
  final ApiClient _client;
  UserRepoImpl({required ApiClient client}) : _client = client;

  @override
  Future<ApiResult<List<UserListEntity>>> searchUsers({
    required String keyword,
  }) async {
    try {
      final response = await _client.get(
        path: ApiEndpoints.user.searchUsers(keyword: keyword),
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
  Future<ApiResult<dynamic>> getUserDetails({required String username}) async {
    try {
      final response = await _client.get(
        path: ApiEndpoints.user.getUserDetails(username: username),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e);
    }
  }

  @override
  Future<ApiResult<dynamic>> getUserRepos({required String username}) async {
    try {
      final response = await _client.get(
        path: ApiEndpoints.user.getUserRepos(username: username),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e);
    }
  }
}
