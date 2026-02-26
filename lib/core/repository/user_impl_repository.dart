import 'package:flutter_github_api/core/api/api_endpoints.dart';
import 'package:flutter_github_api/core/api/api_result.dart';
import 'package:flutter_github_api/core/api/client.dart';
import 'package:flutter_github_api/core/repository/user_repository.dart';

class UserRepoImpl extends UserRepo {
  final ApiClient _client;
  UserRepoImpl({required ApiClient client}) : _client = client;

  @override
  Future<ApiResult<dynamic>> searchUsers({required String keyword}) async {
    try {
      final response = await _client.get(
        path: ApiEndpoints.user.searchUsers(keyword: keyword),
      );
      return ApiResult.success(response);
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
